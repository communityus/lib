package Lacuna::DB::Result::Building::Waste;

use Moose;
no warnings qw(uninitialized);
extends 'Lacuna::DB::Result::Building';

around 'build_tags' => sub {
    my ($orig, $class) = @_;
    return ($orig->($class), qw(Resources Waste));
};

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
