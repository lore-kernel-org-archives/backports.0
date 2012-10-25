MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <50895699.6060009@hauke-m.de>
References: <20121024201437.368EB40ABF@repository3.orbit-lab.org>
	<CAFub=KTgcjeNuL6T3aoV8g3pd4GeQu6QboUeNEMTjcRcq5Ji_w@mail.gmail.com>
	<50895699.6060009@hauke-m.de>
Date: Thu, 25 Oct 2012 08:20:24 -0700
Message-ID: <CAB=NE6Uh0ZXAA=RiLNwL4X0+JjyTzE4YyR3DCMCdJei-hdedLw@mail.gmail.com>
Subject: Re: Compat-wireless release for 2012-10-24 is baked
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>,
	backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Thu, Oct 25, 2012 at 8:11 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 10/25/2012 04:57 PM, Ozan =C3=87a=C4=9Flayan wrote:
>> On Wed, Oct 24, 2012 at 11:14 PM, Compat-wireless cronjob account
>> <compat@orbit-lab.org> wrote:
>>> git fetch github (/var/opt/compat/compat-wireless-2.6)
>>> HEAD is now at a26c7c1 compat-drivers: Enable CONFIG_DRM_LOAD_EDID_FIRM=
WARE
>>> git fetch github (/var/opt/compat/compat)
>>> Nothing new to pack.
>>> HEAD is now at 8de8ebb compat: encourage non-root use of bin/get-compat=
-kernels
>>> git fetch  (/var/opt/compat/linux-next)
>>> Nothing new to pack.
>>> HEAD is now at d1298f5 Add linux-next specific files for 20121024
>>> Error while updating from wireless-testing
>>
>> Do we have the code of these cron scripts anywhere on the net? Would
>> you consider to run bin/get-compat-trees before running this script to
>> fetch the latest kernels?
>
> Hi Ozan,
>
> The code of the scripts is here:
> https://git.kernel.org/?p=3Dlinux/kernel/git/mcgrof/compat-user.git;a=3Ds=
ummary
>
> Doesn't get-compat-trees need root rights?

Not anymore!

  Luis
