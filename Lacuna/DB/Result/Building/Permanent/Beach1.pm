package Lacuna::DB::Result::Building::Permanent::Beach1;

use Moose;
use utf8;
no warnings qw(uninitialized);
extends 'Lacuna::DB::Result::Building::Permanent';

use constant controller_class => 'Lacuna::RPC::Building::Beach1';

with "Lacuna::Role::Building::FormsNaturally";

sub can_upgrade {
    confess [1013, "You can't upgrade a beach. It forms naturally."];
}
use constant algae_production => 10; 
around produces_food_items => sub {
    my ($orig, $class) = @_;
    my $foods = $orig->($class);
    push @{$foods}, qw(algae);
    return $foods;
};
use constant ore_production => 10; 
use constant water_production => 10; 
use constant image => 'beach1';

sub image_level {
    my ($self) = @_;
    return $self->image.'1';
}

use constant name => 'Beach [1]';

use constant time_to_build => 0;

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
