#!/usr/bin/perl
package JMX::Jmx4Perl::ProductHandler::Glassfish2;

use JMX::Jmx4Perl::ProductHandler::BaseHandler;
use strict;
use base "JMX::Jmx4Perl::ProductHandler::BaseHandler";

use Carp qw(croak);

=head1 NAME

JMX::Jmx4Perl::ProductHandler::Glassfish - Product handler for accessing
Glassfish specific namings

=head1 DESCRIPTION

This handler supports glassfish version 2.

=cut

sub id {
    return "glassfish2";
}

sub name {
    return "Glassfish";
}

sub autodetect {
    my $self = shift;
    return $self->try_attribute("version","com.sun.appserv:category=runtime,j2eeType=J2EEDomain,name=com.sun.appserv","applicationServerFullVersion");
}

sub version {
    my $self = shift;
    $self->try_attribute("version","com.sun.appserv:category=runtime,j2eeType=J2EEDomain,name=com.sun.appserv","applicationServerFullVersion")
      unless defined $self->{version};
    return $self->{version};
}

sub jsr77 {
    return 1;
}

sub _init_aliases {
    return 
    {
     attributes => 
   {
    SERVER_VERSION => [ "com.sun.appserv:category=runtime,j2eeType=J2EEDomain,name=com.sun.appserv","applicationServerFullVersion" ],
   },
     operations => 
   {
    THREAD_DUMP => [ "com.sun.appserv:category=monitor,server=server,type=JVMInformation", "getThreadDump"]
   }
     # Alias => [ "mbean", "attribute", "path" ]
    };
}

sub description { 
    my ($self,$jmx4perl) = @_;
}


=head1 LICENSE

This file is part of jmx4perl.

Jmx4perl is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

jmx4perl is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with jmx4perl.  If not, see <http://www.gnu.org/licenses/>.

A commercial license is available as well. Please contact roland@cpan.org for
further details.

=head1 AUTHOR

roland@cpan.org

=cut

1;
