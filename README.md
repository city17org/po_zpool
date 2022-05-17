PO\_ZPOOL(8) - FreeBSD System Manager's Manual

# NAME

**po\_zpool** - send pushover notifications for zpool health

# SYNOPSIS

**po\_zpool**
\[**-d**]
\[**-t**&nbsp;*title*]

# DESCRIPTION

**po\_zpool**
is a utility that will send a pushover notification if
zpool-status(8)
shows that any pool is in a state other than healthy, using the output of this
command as the message body.

The
*po\_token*
and
*po\_user*
variables must be defined within the script before use and should contain the
*USER\_KEY*
and
*API\_TOKEN*
for an application registered with
[https://pushover.net](https://pushover.net).

The options are as follows:

**-d**

> Debug mode.
> Always send a pushover notification.

**-t** *title*

> Set the message's title.
> If unset,
> hostname(1)
> will be used.

# EXIT STATUS

The **po\_zpool** utility exits&#160;0 on success, and&#160;&gt;0 if an error occurs.

# EXAMPLES

The following is an example
crontab(5)
entry to run every 5 minutes.

	*/5 * * * * /usr/home/charlie/bin/po_zpool.sh

# SEE ALSO

curl(1),
hostname(1),
crontab(5),
cron(8),
zpool-status(8)

[https://pushover.net/api](https://pushover.net/api)

# AUTHORS

Sean Davies &lt;[sean@city17.org](mailto:sean@city17.org)&gt;

# CAVEATS

Depends on
curl(1).

FreeBSD 13.0-RELEASE-p11 - May 4, 2022
