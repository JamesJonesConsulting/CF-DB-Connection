package CF::DB::Connection;

use 5.018002;
use KiokuDB;
use DBI;
use Moose;

our $VERSION = '0.01';

has 'config' => ( is => 'rw', isa => 'HashRef', default => sub { {} } );
has 'dbhs' => ( is => 'rw', isa => 'HashRef', default => sub { {} }, init_arg => undef );
has 'kdbhs' => ( is => 'rw', isa => 'HashRef', default => sub { {} }, init_arg => undef );

# Preloaded methods go here.
sub getConnection {
    my $self = shift;
    my $key = shift;
    if(exists($self->dbhs->{$key})) {
        return $self->dbhs->{$key};
    }
    if(exists $self->config->{$key}) {
        $self->dbhs->{$key} = DBI->connect(
            $self->config->{$key}{'dsn'}, 
            $self->config->{$key}{'user'}, 
            $self->config->{$key}{'password'}, 
            {
                PrintError => 1,
                RaiseError => 0
            }
        );
        return $self->dbhs->{$key};
    } else {
        die 'No config exists for named connection: $key';
    }
}
sub getKiokuConnection {
    my $self = shift;
    my $key = shift;
    if(exists($self->kdbhs->{$key})) {
        return $self->kdbhs->{$key};
    }
    if(exists $self->config->{$key}) {
        $self->kdbhs->{$key} = KiokuDB->connect(
            $self->config->{$key}{'dsn'},
            user     => $self->config->{$key}{'user'},
            password => $self->config->{$key}{'password'},
        );
        return $self->kdbhs->{$key};
    } else {
        die 'No config exists for named connection: $key';
    }
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

CF::DB::Connection - Perl extension for blah blah blah

=head1 SYNOPSIS

  use CF::DB::Connection;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for CF::DB::Connection, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

James Jones, E<lt>jamjon3@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by James Jones

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
