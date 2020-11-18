package Lacuna::RPC::Building::Espionage;

use Moose;
no warnings qw(uninitialized);
extends 'Lacuna::RPC::Building';

sub app_url {
    return '/espionage';
}

sub model_class {
    return 'Lacuna::DB::Result::Building::Espionage';
}

no Moose;
__PACKAGE__->meta->make_immutable;

