[![Build Status](https://secure.travis-ci.org/robn/Slack-Notify.png)](http://travis-ci.org/robn/Slack-Notify)

# NAME

Slack-Notify - Trigger Slack incoming webhooks

# SYNOPSIS

    use Slack::Notify;

    my $n = Slack::Notify->new(
      hook_url => 'https://hooks.slack.com/services/...',
    );

    $n->post(
      text => "something happened",
    );

# DESCRIPTION

This is a simple client for [Slack incoming webhooks](https://api.slack.com/incoming-webhooks).

Create a `Slack::Notify` object with the URL of an incoming hook, then call
the `post` method to trigger it.

# CONSTRUCTOR

## new

    my $n = Slack::Notify->new;

This constructor returns a new Slack::Notify object. Valid arguments include:

- `hook_url`

    The Slack incoming hook URL. Create one of these in the Slack integrations config.

# METHODS

## post

    $n->post(
      text => 'something happened',

Triggers the hook. There's several arguments you can supply, which are
described in more detail in the
[incoming hook documentation](https://api.slack.com/incoming-webhooks).

- `text`

    A simple, multi-line message without special formatting.

- `blocks`

    A reference to an array containing
    [BlockKit](https://api.slack.com/reference/block-kit) blocks.  (You don't need
    this if you're just sending `text`.)

- `username`

    Value to use for the username, overriding the one set in the hook config.

- `icon_url`

    URL of an image to use for the icon, overriding the one set in the hook config.

- `icon_emoji`

    An emoji code (eg `:+1:`) to use for the icon, overriding the one set in the hook config.

- `channel`

    A channel name or user to direct to direct the message into, overriding the one set in the hook config.

- `attachments`

    An arrayref containing some attachment objects. See the
    [attachment guide](https://api.slack.com/docs/message-attachments) for details.
    At the moment this module supports attachment fields, but not buttons, menus
    and other interactive ocontent.

# SUPPORT

## Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at [https://github.com/robn/Slack-Notify/issues](https://github.com/robn/Slack-Notify/issues).
You will be notified automatically of any progress on your issue.

## Source Code

This is open source software. The code repository is available for
public review and contribution under the terms of the license.

[https://github.com/robn/Slack-Notify](https://github.com/robn/Slack-Notify)

    git clone https://github.com/robn/Slack-Notify.git

# AUTHORS

- Rob Norris <robn@despairlabs.com>

# CONTRIBUTORS

- Ricardo Signes <rjbs@semiotic.systems>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Rob Norris

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
