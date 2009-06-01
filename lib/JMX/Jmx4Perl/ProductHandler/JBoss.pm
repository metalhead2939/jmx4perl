#!/usr/bin/perl
package JMX::Jmx4Perl::ProductHandler::JBoss;

use JMX::Jmx4Perl::ProductHandler::BaseHandler;
use strict;
use base "JMX::Jmx4Perl::ProductHandler::BaseHandler";

use Carp qw(croak);

=head1 NAME

JMX::Jmx4Perl::ProductHandler::JBoss - Product handler for accessing JBoss
specific namings

=head1 DESCRIPTION

This is the product handler support JBoss 4.x and JBoss 5.x

In order to access the JVM JMX properties, you have to start JBoss including
the following C<JAVA_OPTIONS>

   -Djavax.management.builder.initial=org.jboss.system.server.jmx.MBeanServerBuilderImpl \
   -Djboss.platform.mbeanserver

I.e. you can use C<run.sh> like

   JAVA_OPTS="-Djavax.management.builder.initial=org.jboss.system.server.jmx.MBeanServerBuilderImpl -Djboss.platform.mbeanserver" bin/run.sh

=cut

sub id {
    return "jboss";
}

sub name {
    return "JBoss";
}

sub autodetect {
    my $self = shift;
    return $self->try_attribute("version","jboss.system:type=Server","VersionNumber");
}

sub version {
    my $self = shift;
    $self->try_attribute("version","jboss.system:type=Server","VersionNumber") 
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
    SERVER_VERSION => [ "jboss.system:type=Server", "VersionNumber"],
    SERVER_ADDRESS => [ "jboss.system:type=ServerInfo", "HostAddress"],
    SERVER_HOSTNAME => [ "jboss.system:type=ServerInf", "HostName"],
   },
     operations => 
   {
    THREAD_DUMP => [ "jboss.system:type=ServerInfo", "listThreadDump"]
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
