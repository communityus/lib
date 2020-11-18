package Lacuna::DB::Result::Building::Permanent::Beach4;

use Moose;
no warnings qw(uninitialized);
extends 'Lacuna::DB::Result::Building::Permanent';

use constant controller_class => 'Lacuna::RPC::Building::Beach4';

sub check_build_prereqs {
    my ($self, $body) = @_;
    if ($body->get_plan(__PACKAGE__, 1)) {
        return 1;  
    }
    confess [1013,"You can't build a beach. It forms naturally."];
}

sub can_upgrade {
    confess [1013, "You can't upgrade a beach. It forms naturally."];
}

use constant image => 'beach4';

sub image_level {
    my ($self) = @_;
    return $self->image.'1';
}

use constant name => 'Beach [4]';

use constant time_to_build => 0;

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
