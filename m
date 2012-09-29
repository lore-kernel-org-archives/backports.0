Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ebiederm@xmission.com>
In-Reply-To: <1348900705-12431-2-git-send-email-mcgrof@do-not-panic.com>
References: <1348900705-12431-1-git-send-email-mcgrof@do-not-panic.com> <1348900705-12431-2-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Sat, 29 Sep 2012 00:49:23 -0700
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,backports@vger.kernel.org
CC: Serge Hallyn <serge.hallyn@canonical.com>
Message-ID: <7df08404-c68b-4e3d-9bf8-ff04bbfa1160@email.android.com>
Subject: Re: [PATCH 1/3] compat: backport uidgid.h kuid_t and kgid_t addition
List-ID: <backports@vger.kernel.org>

I don't know the discipline you keep for the compat backports.

However I e=
xpect you can simplify this bit considerably by removing the USER_NS case a=
s it will never be true, except in 3.5 where this code already in exists.

=
You can further simplify things by leaving out the overflowuid and overflow=
gid cases from from_kuid_munged, as for a backport I doubt anyon will care =
if the value is -1 or overflowuid.

Eric
