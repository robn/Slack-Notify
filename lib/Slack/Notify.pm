package Slack::Notify {

# ABSTRACT: Trigger Slack incoming webhooks

use namespace::autoclean;

use HTTP::Tiny;

use Moo;
use Types::Standard qw(Str);
use Type::Utils qw(class_type);

has hook_url => ( is => 'ro', isa => Str, required => 1 );

has _http => ( is => 'lazy', isa => class_type('HTTP::Tiny') );
sub _build__http { HTTP::Tiny->new }

sub post {
  my ($self, %args) = @_;
  my $payload = Slack::Notify::Payload->new(%args);
  $self->_http->post_form(
    $self->hook_url,
    { payload => $payload->to_json },
  );
}

}

package # hide from PAUSE
  Slack::Notify::Payload {

use namespace::autoclean;

use Moo;
use Types::Standard qw(Str);

use JSON::MaybeXS;

has text       => ( is => 'ro', isa => Str );
has username   => ( is => 'ro', isa => Str );
has icon_url   => ( is => 'ro', isa => Str );
has icon_emoji => ( is => 'ro', isa => Str );

sub to_json { shift->_json }
has _json => ( is => 'lazy', isa => Str );
sub _build__json {
  my ($self) = @_;
  encode_json({
    defined $self->text       ? ( text       => $self->text       ) : (),
    defined $self->username   ? ( username   => $self->username   ) : (),
    defined $self->icon_url   ? ( icon_url   => $self->icon_url   ) : (),
    defined $self->icon_emoji ? ( icon_emoji => $self->icon_emoji ) : (),
  });
}

}

1;

=pod

=encoding UTF-8

=for markdown [![Build Status](https://secure.travis-ci.org/robn/Slack-Notify.png)](http://travis-ci.org/robn/Slack-Notify)

=head1 NAME

Slack-Notify - Trigger Slack incoming webhooks

=head1 SYNOPSIS

    use Slack::Notify;

    my $n = Slack::Notify->new(
      hook_url => 'https://hooks.slack.com/services/...',
    );

    $n->post(
      text => "something happened",
    );

=head1 DESCRIPTION

This is a simple client for L<Slack incoming webhooks|https://api.slack.com/incoming-webhooks>.

Create a C<Slack::Notify> object with the URL of an incoming hook, then call
the C<post> method to trigger it.

=head1 CONSTRUCTOR

=head2 new

    my $n = Slack::Notify->new;

This constructor returns a new Slack::Notify object. Valid arguments include:

=over 4

=item *

C<hook_url>

The Slack incoming hook URL. Create one of these in the Slack integrations config.

=back

=head1 METHODS

=head2 post

    $n->post(
      text => 'something happened',

Triggers the hook. There's several arguments you can supply, which are
described in more detail in the
L<incoming hook documentation|https://api.slack.com/incoming-webhooks>.

=over 4

=item *

C<text>

A simple, multi-line message without special formatting.

=item *

C<username>

Value to use for the username, overriding the one set in the hook config.

=item *

C<icon_url>

URL of an image to use for the icon, overriding the one set in the hook config.

=item *

C<icon_emoji>

An emoji code (eg C<:+1:>) to use for the icon, overriding the one set in the hook config.

=back

=head1 SUPPORT

=head2 Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at L<https://github.com/robn/Slack-Notify/issues>.
You will be notified automatically of any progress on your issue.

=head2 Source Code

This is open source software. The code repository is available for
public review and contribution under the terms of the license.

L<https://github.com/robn/Slack-Notify>

  git clone https://github.com/robn/Slack-Notify.git

=head1 AUTHORS

=over 4

=item *

Rob N ★ <robn@robn.io>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Rob N ★

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
