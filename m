Return-path: <backports-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57916 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752633AbbGUAYm (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 20 Jul 2015 20:24:42 -0400
Date: Tue, 21 Jul 2015 02:24:39 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: backports@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Konstantin Ryabitsev <mricon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kyle@kernel.org, luto@amacapital.net, Jiri Slaby <jslaby@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <sasha.levin@oracle.com>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: RFC: use of PGP keys for deprecating Linux related software
Message-ID: <20150721002438.GG30479@wotan.suse.de> (sfid-20150721_022444_849926_C2B8F6FF)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I'd like input on whether or not using different PGP subkeys for purposes of
making new software releases but *also* a different subkey for purposes of
deprecating software releases might be a reasonable way forward to help with
automation of figuring out what releases to list as supported / eol.

Let me explain:

On the Linux 802.11 subsystem we had quite a bit of tiny userspace
applications, writing their own home page seemed rather silly and pointless,
specially as most documentation these days was done through wikis. Users still
need a central place to go to find the latest releases, references to the wikis
(or whatever home page they need), an e-mail list posted which users can
subsribe to ask questions or post patches, and some basic licensing
information.  Since we had quite a bit of these small userspace tools I wrote a
tool, rel-html [0] to write a shiny simple HTML5 project page for projects
provided you give a basic configuration file. This has worked swell for a
series of tools and some projects:

  * iw
  * wireless-regdb
  * crda
  * backports

For sport I wrote support for Linux releases as well. Although this currently
supports parsing naked project html pages to look for releases my goal is to
get it to support reading json files to read the list of suported releases.
For instance Linux has this json file for releases, which I'd like to use
as a template:

https://www.kernel.org/releases.json

I'd like to mimic this practice for the Linux backports project but before we do
so I would also like to take automation one step further but by keeping things
simple for the developers involved, so that they don't *have* to get involved
with the front end in any way shape or form and we can just somehow infer things.
For instance every time a new EOL (end of life) is done on a Linux release the
configuration file needs to be updated. Likewise all supported releases need to
be listed. This also means all new releases need to be added on to the rel-html
configuration file for backports... This is quite silly, it means these days we
have to make a one line change commit on the rel-html project every time a new Linux
release is made and therefore a new Linux backports release is made. I'd like
to put an end to this silly practice and just infer the latest supported releases.

Since all software we support mimics the versioning scheme used by Linux we
have an easy way to compute release weights and a library to sort these out for
us so we can easily determine what are the latest releases on a git tree
provided all you do is:

git tag -l

These days you can just use gpg tag -s to digitally sign your release tag
with a PGP key (or subkey). Fortunately This is standard practice, but what we
don't have a standard practice for doing though is for release deprecation and
I'm thinking that using a different PGP key/subkey for deprecation purposes might fit
nicely to the automation scheme. One can then for instance have on the
configuration file the first supported release version tag, then use the list
of tags on 'git tag -l' and only move forward to process tags which have a
greater weight than the first supported release. This would allow us to not
require deprecation signatures for instance on older releases, but we would
then use them for newer releases. To find if a release is deprecated then one
would look at the tags of of a branch, get the latest or heaviest weighted tag 
(weight mimics a similar compuation as LINUX_VERSION_CODE()) and verify if that
tag was signed by a supported subkey or a deprecation subkey. We'd skip all
tags with a deprecation subkey.

One issue I see with this is that since we cannot sign a release twice (git
complains of a conflict), we'd need to bump a release branch if we want to
deprecate it. So for instance, say v4.2 was released, and then we had v4.2.1
and later v4.2.2 but then we knew that at some later point in time that release
must be deprecated, what you would do is to use a 'deprecation' PGP subkey for
v4.2.3. Is this process and the push for a new release bump worth the automation
scheme?

The tool that scrapes then the 'git tag -l' list and which would generate a
json file, would know to skip v4.2.3 or just all the v4.2 releaeses. This scheme
would also allow you to have gaps in supported releases, as we have on Linux,
for instance. To use a different key we'd use 'git tag -u <subkey-id> -s
<new-release-bump>'.

Does this seem like a reasonable light weight process which can help with
automation and detection of release gaps / deprecation, or are there some
issues folks might see with this ?

Note that I seek feedback primarily for the Linux backports project, but Cc'd a
few other folks in case it may seem like sensible practice for Linux as well.

Thanks,

[0] https://git.kernel.org/cgit/linux/kernel/git/mcgrof/rel-html.git/

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
