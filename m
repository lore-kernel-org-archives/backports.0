MIME-Version: 1.0
In-Reply-To: <50B7BC71.4040004@hauke-m.de>
References: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
	<1354144069-28611-6-git-send-email-hauke@hauke-m.de>
	<CAB=NE6VTooMH=mtDOiSw57DXez4E__nwrU_E=R3BHeXZ9jF1LQ@mail.gmail.com>
	<50B7BC71.4040004@hauke-m.de>
Date: Thu, 29 Nov 2012 11:57:01 -0800
Message-ID: <CAB=NE6Xdbjpe9+WJpWm+5j3N80q+SrtRMwrKjFeHufJuXqBt2Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] compat-drivers: add import to fix compile error
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Thu, Nov 29, 2012 at 11:50 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 11/29/2012 08:25 PM, Luis R. Rodriguez wrote:
>> On Wed, Nov 28, 2012 at 3:07 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote=
:
>>> On kernel version <=3D 2.6.28, I saw the following compile error withou=
t
>>> this patch:
>>>
>>> /net/wireless/util.c: In function =E2=80=98cfg80211_get_p2p_attr=E2=80=
=99:
>>> /net/wireless/util.c:1120:4: error: implicit declaration of function
>>> =E2=80=98get_unaligned_le16=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>> ---
>>>  patches/network/06-header-changes.patch |   10 ++++++++++
>>>  patches/network/30-bridge-port.patch    |    2 +-
>>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/patches/network/06-header-changes.patch b/patches/network/=
06-header-changes.patch
>>> index cd587cd..5da05c0 100644
>>> --- a/patches/network/06-header-changes.patch
>>> +++ b/patches/network/06-header-changes.patch
>>> @@ -125,3 +125,13 @@ cases.
>>>
>>>   #define USB_VERSION   "1.0"
>>>
>>> +--- a/net/wireless/util.c
>>> ++++ b/net/wireless/util.c
>>> +@@ -10,6 +10,7 @@
>>> + #include <net/cfg80211.h>
>>> + #include <net/ip.h>
>>> + #include <net/dsfield.h>
>>> ++#include <asm/unaligned.h>
>>
>> Interesting, I wonder if we should just get a compat header to add
>> this therefore not requiring any patching.
>
> Probably some of the header files included also include asm/unaligned.h
> on kernel versions > 2.6.28. You could add all the includes added in
> this patch to compat-X.h to get rid of this entire patch, but this will
> increase the risk of name clashes.

True.. I'll merge in for now and we can later try adding it and test
compiling, if we get no classes then we can move it upstream.

>>> + #include "core.h"
>>> + #include "rdev-ops.h"
>>> +
>>> diff --git a/patches/network/30-bridge-port.patch b/patches/network/30-=
bridge-port.patch
>>> index b4106b7..a426274 100644
>>> --- a/patches/network/30-bridge-port.patch
>>> +++ b/patches/network/30-bridge-port.patch
>>> @@ -23,7 +23,7 @@ compat-drivers.
>>>
>>>  --- a/net/wireless/util.c
>>>  +++ b/net/wireless/util.c
>>> -@@ -812,7 +812,7 @@ int cfg80211_change_iface(struct cfg8021
>>> +@@ -813,7 +813,7 @@ int cfg80211_change_iface(struct cfg8021
>>>                 return -EOPNOTSUPP;
>>>
>>
>> This hunk does not seem to be relevant so I'll discard it.
>
> The offset of this change in the patch changed because of the additional
> header being added in the previous patch. I am always refreshing the
> patches after doing some changes to them to make all apply cleanly.

Got it, I'd prefer we keep refreshes separate if possible given that I
think it'd be good we can keep track of automatic refreshes Vs manual
fixes required on patches between two releases. I'm a statistics
junky, but do think this can help in the long run to separate and
analyze the different types of changes required to keep doing
backporting.

  Luis
