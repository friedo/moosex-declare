package MooseX::Declare::Context::Version;

use Moose::Role;
use Carp 'croak';

use namespace::clean -except => 'meta';
use version 0.77;

has version => (
    is      => 'rw',
    isa     => 'Maybe[version]',
    default => undef,
    lazy    => 1
);

sub strip_version { 
    my $self = shift;

    # Make errors get reported from right place in source file
    local $Carp::Internal{'MooseX::Declare'} = 1;
    local $Carp::Internal{'Devel::Declare'} = 1;

    $self->skipspace;
    my $linestr = $self->get_linestr;


    if ( substr( $linestr, $self->offset, 1 ) =~ /[v\d]/ ) { 
        my ( $vnum ) = $linestr =~ m{(v?\d[\d\.]*)};
        $vnum = 'v' . $vnum unless $vnum =~ /^v/;

        unless( defined $vnum ) { 
            croak 'expected version number';
        }


        my $version = version->parse( $vnum );

        $self->version( $version );

        substr $linestr, $self->offset, length $vnum, '';

        $self->set_linestr( $linestr );

        return $version;
    }

    return;
}


1;
  
