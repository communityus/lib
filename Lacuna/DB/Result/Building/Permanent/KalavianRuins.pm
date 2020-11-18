package Lacuna::DB::Result::Building::Permanent::KalavianRuins;

use Moose;
no warnings qw(uninitialized);
extends 'Lacuna::DB::Result::Building::Permanent';

use constant controller_class => 'Lacuna::RPC::Building::KalavianRuins';

sub check_build_prereqs {
    my ($self, $body) = @_;
    if ($body->get_plan(__PACKAGE__, 1)) {
        return 1;  
    }
    confess [1013,"You can't build the Kalavian Ruins. They were left behind by the Great Race."];
}

sub can_upgrade {
    confess [1013, "You can't upgrade the Kalavian Ruins. They were left behind by the Great Race."];
}

use constant image => 'kalavianruins';

sub image_level {
    my ($self) = @_;
    return $self->image.'1';
}

use constant name => 'Kalavian Ruins';

use constant time_to_build => 0;
use constant max_instances_per_planet => 1;
use constant happiness_production => 4000;


no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
