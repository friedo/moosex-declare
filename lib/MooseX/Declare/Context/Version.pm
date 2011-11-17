package MooseX::Declare::Context::Version;

use Moose::Role;
use Carp 'croak';

use namespace::clean -except => 'meta';
use version 0.77;

has version => (
    is      => 'ro',
    isa     => 'version',
    default => sub { version->new },
    lazy    => 1
);

sub strip_version { 
    my $self = shift;

    warn 'stripping version';

    # Make errors get reported from right place in source file
    local $Carp::Internal{'MooseX::Declare'} = 1;
    local $Carp::Internal{'Devel::Declare'} = 1;

    $self->skipspace;
    my $linestr = $self->get_linestr;

    warn "version linestr = [$linestr]";

    if ( substr( $linestr, $self->offset, 1 ) =~ /[v\d]/ ) { 
        my $vnum = $self->strip_name;

        warn "vnum = [$vnum]";

        unless( defined $vnum ) { 
            croak 'expected version number';
        }


        my $version = version->new( $vnum );

        $self->version( $version );

        return $version;
    }

    return;
}


1;
  
