package Lacuna::DB::Result::Building::GasGiantLab;

use Moose;
no warnings qw(uninitialized);
extends 'Lacuna::DB::Result::Building';

around 'build_tags' => sub {
    my ($orig, $class) = @_;
    return ($orig->($class), qw(Infrastructure Colonization Ships));
};

use constant controller_class => 'Lacuna::RPC::Building::GasGiantLab';

use constant university_prereq => 17;

use constant image => 'gas-giant-lab';

use constant name => 'Gas Giant Lab';

use constant food_to_build => 300;

use constant energy_to_build => 300;

use constant ore_to_build => 340;

use constant water_to_build => 300;

use constant waste_to_build => 150;

use constant time_to_build => 600;

use constant food_consumption => 12;

use constant energy_consumption => 22;

use constant ore_consumption => 7;

use constant water_consumption => 12;

use constant waste_production => 22;


no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
