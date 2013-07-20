Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54466 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754072Ab3GTOPp (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 20 Jul 2013 10:15:45 -0400
Message-ID: <51EA9B80.8040301@hauke-m.de> (sfid-20130720_161547_676445_E9F3483F)
Date: Sat, 20 Jul 2013 16:15:28 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Solomon Peachy <pizza@shaftnet.org>
CC: backports@vger.kernel.org
Subject: Re: cw1200 and older kernels (newbie question)
References: <20130720122708.GA24056@shaftnet.org>
In-Reply-To: <20130720122708.GA24056@shaftnet.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/20/2013 02:27 PM, Solomon Peachy wrote:
> As part of the cw1200 mainlining effort, I stripped two chunks out
> of the cw1200 driver that only had relevance relevance for older
> kernels:
> 
> 1) Workaround for a hardware SDIO bug (needed for < 3.2) * Formal
> SDIO-level quirk mainlined in 3.2-rc * Absence results in device
> hang with 512-byte SDIO transfers. 2) Support for kernels < 2.6.36 
> * Driver utilizes the new workqueue API introduced in 2.6.36,
> taking advantage of new semantics/features (WQ_HIGHPRI +
> WQ_CPU_INTENSIVE) * With older kernels we need a dedicated kthread
> 
> Backports has an implementation of the new workqueue API, but it is
>  expressed in terms of the old API, which is inadequate for the
> cw1200's needs.
> 
> Perhaps it's a lack of sufficient sleep, but I haven't quite
> wrapped my head around how the bakports stuff is put together; it's
> radically different that compat-wireless, which had nice orderly
> patch directories.  :)
> 
> Any advice on how I should proceed here?  I want to do this the 
> RightWay, but I don't know what that is yet -- Should I just add
> these two patches to the backports tree under
> patches/unified-drivers?
> 
> (The code chunks in question are wrapped with LINUX_VERSION_CODE
> tests, so they function fine on newer kernels)
> 
> - Solomon
> 
Hi Solomon,

We have a documentation for that in the wiki [0]. Just ask if you have
any further questions. There are some pending changes regarding the
workqueue API changes in the kernel, you should base your work on top
of that [1].

Hauke

[0]:
https://backports.wiki.kernel.org/index.php/Documentation/backports/hacking
[1]: http://www.spinics.net/lists/backports/msg01505.html
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR6pt7AAoJEIZ0px9YPRMyTv4P/0cWlLLx0lT3Ocdc1GR0y5R+
CNkOQXJTQPl2ft8yCD5kpuUF2NylknD8GX+wVreDf8BscTauSBC4yw5o3OWp5QAC
t3gYYxeBupJvAjbWuJ61JFe5b9wTOM+Vc2cPBFdJoMGCy/iEc7cRkAJDwQMKnMnS
N6rEtIvxk+tJjGb6UgagLPDGpwVxu+XCKPIAabWB4M/8oZjz+eGQXm9JqveP6Q2Q
KsWJvPeq1CwEVFHeVAiVEF6TlV5sF0h+CivMegjMfGnRWB2ojLnNDnBv9DT0pVJz
dsPXgHvoKJNpU5oMguFWuHmvUaljnjBxXvXhHIzIYsmEMeRVIprPaQKVk9B9wSER
W/GWkQOgKlhpNYgFe++6Ktt3dVb2omm4mLfeWgGK8RoWXpH1skp9IMyzt22vrRON
n2ASW1E7gcnAYWhEl/WjGWSyMdqfV0LZF2forJhsBA9GhcdoEqdedMQWzh7lRHOb
OGgj5zhihWJiw69IiBUNpmtIGTw9YYRLFbPUxNf/WBwlcSZFpguXyAfB6G7x5UFw
90PSxg0nTsoT6DWQDSzORLucAm571sHFkwpyj6gBO+qEcZnk8XKx8KjfvM9AQZIl
4QL1wDZK5JrWTkpPSUgJTINUfrOVZTDZAMKsbOdWpeFEuu/fsghA5dyA45nPZgGw
ZRhflmc8ulHQ46KryJiC
=rPy0
-----END PGP SIGNATURE-----
