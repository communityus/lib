package KA::DB::Result::Law::MembersOnlyColonization;

use Moose;
use utf8;
no warnings qw(uninitialized);
extends 'KA::DB::Result::Law';

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
