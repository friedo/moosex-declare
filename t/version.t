#!/usr/bin/env perl

use strict;
use warnings;

use MooseX::Declare;
use Test::More tests => 4;

class Foo::Bar 1.2.3 { 

}

class Foo::Baz 2.3.4 extends Foo::Bar {

}

role Foo::Narf v3.4.5 {

}

class Foo::Quux v4.5.6 extends Foo::Bar with Foo::Narf {

}

is( Foo::Bar->VERSION,  'v1.2.3' );
is( Foo::Baz->VERSION,  'v2.3.4' ); 
is( Foo::Narf->VERSION, 'v3.4.5' );
is( Foo::Quux->VERSION, 'v4.5.6' );


