package Lacuna::RPC::Building::WasteEnergy;

use Moose;
no warnings qw(uninitialized);
extends 'Lacuna::RPC::Building';

sub app_url {
    return '/wasteenergy';
}

sub model_class {
    return 'Lacuna::DB::Result::Building::Energy::Waste';
}

no Moose;
__PACKAGE__->meta->make_immutable;

