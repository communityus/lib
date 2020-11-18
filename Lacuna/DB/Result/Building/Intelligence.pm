package Lacuna::DB::Result::Building::Intelligence;

use Moose;
no warnings qw(uninitialized);
extends 'Lacuna::DB::Result::Building';

around 'build_tags' => sub {
    my ($orig, $class) = @_;
    return ($orig->($class), qw(Infrastructure Intelligence));
};

use constant controller_class => 'Lacuna::RPC::Building::Intelligence';

use constant max_instances_per_planet => 1;

use constant university_prereq => 2;

use constant image => 'intelligence';

use constant name => 'Intelligence Ministry';

use constant food_to_build => 83;

use constant energy_to_build => 82;

use constant ore_to_build => 82;

use constant water_to_build => 83;

use constant waste_to_build => 70;

use constant time_to_build => 150;

use constant food_consumption => 70;

use constant energy_consumption => 10;

use constant ore_consumption => 2;

use constant water_consumption => 70;

use constant waste_production => 1;

sub max_spies {
    my ($self) = @_;
    return $self->level;
}

has spy_count => (
    is          => 'rw',
    lazy        => 1,
    default     => sub {
        my $self = shift;
        return $self->get_spies->count;
    },
);

has latest_spy => (
    is          => 'rw',
    lazy        => 1,
    default     => sub {
        my $self = shift;
        return $self->get_spies->search(
            {
                available_on    => ['>=', DateTime->now],
                task            => 'training',
            },
            {
                order_by    => { -desc => 'available_on' },
                rows        => 1,
            }
        )->next;
    },
);

sub get_spies {
    my ($self) = @_;
    return Lacuna->db->resultset('Lacuna::DB::Result::Spies')->search({ from_body_id => $self->body_id });
}

sub get_spy {
    my ($self, $spy_id) = @_;
    my $spy = Lacuna->db->resultset('Lacuna::DB::Result::Spies')->find($spy_id);
    unless (defined $spy) {
        confess [1002, 'No such spy.'];
    }
    if ($spy->from_body_id ne $self->body_id) {
        confess [1013, "You don't control that spy."];
    }
    return $spy;
}

has espionage_level => (
    is      => 'rw',
    lazy    => 1,
    default => sub {
        my $self = shift;
        my $building = $self->body->get_building_of_class('Lacuna::DB::Result::Building::Espionage');
        return (defined $building) ? $building->level : 0;
    },
);

has security_level => (
    is      => 'rw',
    lazy    => 1,
    default => sub {
        my $self = shift;
        my $building = $self->body->get_building_of_class('Lacuna::DB::Result::Building::Security');   
        return (defined $building) ? $building->level : 0;
    },
);

has training_multiplier => (
    is      => 'rw',
    lazy    => 1,
    default => sub {
        my $self = shift;
        my $multiplier = $self->level
            - $self->body->empire->species->deception_affinity
            + $self->espionage_level
            + $self->security_level;
        $multiplier = 1 if $multiplier < 1;
        return $multiplier;
    }
);

sub training_costs {
    my $self = shift;
    my $multiplier = $self->training_multiplier;
    return {
        water   => 1100 * $multiplier,
        waste   => 40 * $multiplier,
        energy  => 100 * $multiplier,
        food    => 1000 * $multiplier,
        ore     => 10 * $multiplier,
        time    => sprintf('%.0f', 2060 * $multiplier / $self->body->empire->species->management_affinity),
    };
}

sub train_spy {
    my ($self, $time_to_train) = @_;
    my $empire = $self->body->empire;
    if ($self->spy_count < $self->max_spies) {
        unless ($time_to_train) {
            $time_to_train = $self->training_costs->{time};
        }
        my $latest = $self->latest_spy;
        my $available_on = (defined $latest) ? $latest->available_on->clone : DateTime->now;
        $available_on->add(seconds => $time_to_train );
        my $deception = $empire->species->deception_affinity * 50;
        Lacuna->db->resultset('Lacuna::DB::Result::Spies')->new({
            from_body_id    => $self->body_id,
            on_body_id      => $self->body_id,
            task            => 'Training',
            started_assignment  => DateTime->now,
            available_on    => $available_on,
            empire_id       => $self->body->empire_id,
            offense         => ($self->espionage_level * 75) + $deception,
            defense         => ($self->security_level * 75) + $deception,
        })
        ->update_level
        ->insert;
        my $count = $self->spy_count($self->spy_count + 1);
        if ($count < $self->level) {
            $self->body->add_news(20,'A source inside %s admitted that they are underprepared for the threats they face.', $empire->name);
        }
    }
    else {
        $empire->send_predefined_message(
            tags        => ['Alert'],
            filename    => 'training_accident.txt',
            params      => [$self->body->name],
        );
        $self->body->add_news(20,'A source inside %s confided that they lost a brave soul in a training accident today.', $empire->name);
    }
    return $self;
}

before delete => sub {
    my ($self) = @_;
    $self->get_spies->delete;
};


no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
