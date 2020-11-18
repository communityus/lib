package Lacuna::DB::Result::Building::Energy::Fission;

use Moose;
no warnings qw(uninitialized);
extends 'Lacuna::DB::Result::Building::Energy';

before check_build_prereqs => sub {
    my $self = shift;
    my $planet = $self->body;
    if ($planet->uraninite + $planet->monazite < 500) {
        confess [1012,"This planet does not have a sufficient supply (500) of radioactive minerals such as Uraninite and Monazite to operate this plant."];
    }
};

use constant controller_class => 'Lacuna::RPC::Building::Fission';

use constant university_prereq => 6;

use constant image => 'fission';

use constant name => 'Fission Reactor';

use constant food_to_build => 250;

use constant energy_to_build => 365;

use constant ore_to_build => 365;

use constant water_to_build => 330;

use constant waste_to_build => 150;

use constant time_to_build => 200;

use constant food_consumption => 1;

use constant energy_consumption => 44;

use constant energy_production => 143;

use constant ore_consumption => 9;

use constant water_consumption => 12;

use constant waste_production => 18;



no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
