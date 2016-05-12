Return-path: <backports-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48296 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbcELAGl (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 May 2016 20:06:41 -0400
Date: Thu, 12 May 2016 08:06:35 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Jouni Malinen <jkmalinen@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	Michal Marek <mmarek@suse.cz>, Takashi Iwai <tiwai@suse.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Huang Ying <ying.huang@intel.com>,
	Philip Li <philip.li@intel.com>
Subject: Re: Linux backports CII badge and run time testing
Message-ID: <20160512000635.GA12984@wfg-t540p.sh.intel.com> (sfid-20160512_020646_601322_D8A16586)
References: <CAB=NE6VJF4kk4EoqA3Lqqp9e2bJqrXvoPmGSHaHs6qr3bX43OA@mail.gmail.com>
 <CANe27jLBmahqRc6ryNxSTKAwo5qkD8NAW+iB8cVGYWOAavF1qA@mail.gmail.com>
 <CAB=NE6V4jYusMZxKw27D+W1_zLSdzP-v9iATeFU45gPYs=VxNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB=NE6V4jYusMZxKw27D+W1_zLSdzP-v9iATeFU45gPYs=VxNQ@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

CC more 0-day developers.

On Wed, May 11, 2016 at 04:14:42PM -0700, Luis R. Rodriguez wrote:
> On Thu, May 5, 2016 at 2:46 AM, Jouni Malinen <jkmalinen@gmail.com> wrote:
> > On Thu, May 5, 2016 at 1:34 AM, Luis R. Rodriguez
> > <mcgrof@do-not-panic.com> wrote:
> >
> >> As for run time testing, we know folks out there in the industry
> >> already use backports and do their own run time tests against drivers,
> >> and this may be automated, we however need something more, at the very
> >> least a boot.
> >
> > All the automated wpa_supplicant/hostapd testing with mac80211_hwsim
> > on my server use Backports: http://buildbot.w1.fi/hwsim/
> 
> Quite impressive work, thanks!
> 
> > The current model does not focus on testing Backports, so I'm only
> > updating that manually every now and then while hostap.git updates are
> > automated (that being the main focus for testing). That said, it would
> > be trivial to update Backports to the latest snapshot whenever running
> > the test. In fact, the same server is already generating snapshot
> > builds of Backports from wireless-testing.git daily.
> 
> Interesting...
> 
> > This is all with a single base kernel version, though, so if you want
> > more coverage in that front, you'd want to run the same setup against
> > multiple kernels.
> 
> Indeed, this raises the question of "what to test" exactly, given
> backports really is a subset of Linux. The automated tests you have
> seem more in line for things perhaps we should get 0-day to consider
> embracing so that if a regression is introduced linux-wireless
> developers are nagged with the respective commit ID and tests cases
> (if this is not done already). Upstream and 0-day seems like a much
> more suitable place to test daily updates on the 802.11 front.
> 
> Backports-wise we should cover at least basic functionality, but
> annotating that if an issue is present on backports with the latest
> linux-next release it may also exist on upstream linux-next, and as
> such not a backports issue but rather an upstream issue. Its this fine
> line of overlap we need a way to somehow remove, and only test things
> which ensure the backporting works for an array of kernels.
> 
> In lack of 0-day integration for wpa_supplicant / hostapd with
> mac80211_hwsim (and leaving aside its debate over doing so or not),
> intuitively I think its a fair assumption to make that linux-next
> mac80211_hwisim should at the very least be able to load and perhaps
> run a series of *basic functionality*. If this is agreeable, and
> reducing the test cases is indeed easy and possible, I think a series
> of basic tests are indeed called for as reasonable for backports to
> integrate for testing as part of its own infrastructure specially
> given 802.11 is a major stakeholder. In that sense, perhaps we can
> cover basic testing for each subsystem, and for 802.11 then testing
> mac80211_hwsim with basic functionality would be our litmus test.
> 
> Thoughts? If agreeable then perhap we just need something similar for
> each subsystem we decide to take on.

FYI 0-day runs simple hwsim tests based on

        git://w1.fi/srv/git/hostap.git

The 0-day test scripts are

        https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/tree/tests/hwsim
        https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/tree/pack/hwsim

We are very interested in hearing improvement suggestions on test coverage,
or be offered new test schemes/scripts to run regularly on new/stable kernels!

Thanks,
Fengguang
--
To unsubscribe from this list: send the line "unsubscribe backports" in
