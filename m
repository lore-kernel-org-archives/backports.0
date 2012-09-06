MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <D38E8E86660E514AB505863C19C9287C41B5835A@ORSMSX101.amr.corp.intel.com>
References: <5023A231020000D6000E4B88@novprvoes0310.provo.novell.com>
	<D38E8E86660E514AB505863C19C9287C41B5835A@ORSMSX101.amr.corp.intel.com>
Date: Thu, 6 Sep 2012 11:02:14 -0700
Message-ID: <CAB=NE6VPWMLEoKTkyEROvTwObALxOLub-n5yc=gKeAfD4YfBfQ@mail.gmail.com>
Subject: Re: [Lf_driver_backport] Some general questions about compat, also
 adding distro kernels
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
To: "Ronciak, John" <john.ronciak@intel.com>
Cc: Ann Davis <andavis@suse.com>,
	"lf_driver_backport@lists.linux-foundation.org" <lf_driver_backport@lists.linux-foundation.org>, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Thu, Sep 6, 2012 at 9:21 AM, Ronciak, John <john.ronciak@intel.com> wrote:
>> 3)  ...Unless the idea is for backporters to just pull the compat
>> functionality into their modules (and thus not provide an actual compat
>> module)?
>
> We don't see this as the way to go.  Intel LAD has this already with our
> stand-alone drivers, granted that it's our own compat code, but I don't
> think you want all the different HW vendors pulling in different versions
> of the compat code in to each driver.  That's just going to cause
> problems and confusion.

And this is solved by prioritizing Linux upstream development given
that once upstream you get to become part of the stable releases that
incorporates all upstream modules sharing the same compat module.
Deltas can be accounted for by the additional patches to stable
releases, which also prioritizes and categorizes patches based on life
cycle on route upstream [0]. This even supports for patches not even
posted for inclusion upstream yet, like typical OEM tools / etc which
typically are not addressed (yet) upstream.

[0] https://backports.wiki.kernel.org/index.php/Documentation/compat-drivers/additional-patches

  LUis
