package Lacuna::RPC::Building::University;

use Moose;
no warnings qw(uninitialized);
extends 'Lacuna::RPC::Building';

sub app_url {
    return '/university';
}

sub model_class {
    return 'Lacuna::DB::Result::Building::University';
}

no Moose;
__PACKAGE__->meta->make_immutable;

