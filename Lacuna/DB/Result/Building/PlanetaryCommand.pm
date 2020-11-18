package Lacuna::DB::Result::Building::PlanetaryCommand;

use Moose;
no warnings qw(uninitialized);
extends 'Lacuna::DB::Result::Building';

around 'build_tags' => sub {
    my ($orig, $class) = @_;
    return ($orig->($class), qw(Infrastructure Resources Ore Water Waste Energy Food Colonization Storage));
};

use constant controller_class => 'Lacuna::RPC::Building::PlanetaryCommand';

sub check_build_prereqs {
    confess [1013,"You can't directly build a Planetary Command. You need a colony ship."];
}

before 'can_demolish' => sub {
    confess [1013, "You cannot demolish the Planetary Commmand."];
};

use constant image => 'command';

use constant name => 'Planetary Command Center';

use constant food_to_build => 320;

use constant energy_to_build => 320;

use constant ore_to_build => 320;

use constant water_to_build => 320;

use constant waste_to_build => 500;

use constant time_to_build => 300;

use constant algae_production => 10;

use constant energy_production => 10;

use constant ore_production => 10;

use constant water_production => 10;

use constant waste_production => 1;

use constant food_storage => 700;

use constant energy_storage => 700;

use constant ore_storage => 700;

use constant water_storage => 700;



no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
