package Lacuna::DB::Result::WeeklyMedalWinner;

use Moose;
no warnings qw(uninitialized);
extends 'Lacuna::DB::Result';

__PACKAGE__->table('weekly_medal_winner');
__PACKAGE__->add_columns(
    empire_id               => { data_type => 'int', is_nullable => 0 },
    empire_name             => { data_type => 'varchar', size => 30, is_nullable => 0 },
    medal_id                => { data_type => 'int', is_nullable => 0 },
    medal_name              => { data_type => 'varchar', size => 50, is_nullable => 0 },
    times_earned            => { data_type => 'int', is_nullable => 0 },
    medal_image             => { data_type => 'varchar', size => 50, is_nullable => 0 },
);


no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
