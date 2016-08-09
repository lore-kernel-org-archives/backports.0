Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53534 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932360AbcHIWPI (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 9 Aug 2016 18:15:08 -0400
Date: Wed, 10 Aug 2016 00:15:06 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Peter Huewe <PeterHuewe@gmx.de>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Re: gentree fails at no such file compat/crypto-skcipher.c
Message-ID: <20160809221506.GG3296@wotan.suse.de> (sfid-20160810_001509_933213_0A05848D)
References: <trinity-50e3397a-cfd4-4f35-ab8b-51700c2a6cf6-1470642723593@3capp-gmx-bs12>
 <CAB=NE6W=-sOfJCTHZSzk1pFC20Zh9R-rELOe2zcoCDhY_hw33Q@mail.gmail.com>
 <01C20278-FFC0-4346-848F-C3B92F031B4E@gmx.de>
 <20160808201407.GV3296@wotan.suse.de>
 <trinity-cbde6023-9aad-4338-a14e-0adb12480dfb-1470718971775@3capp-gmx-bs04>
 <20160809212848.GF3296@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160809212848.GF3296@wotan.suse.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Aug 09, 2016 at 11:28:48PM +0200, Luis R. Rodriguez wrote:
> On Tue, Aug 09, 2016 at 07:02:51AM +0200, Peter Huewe wrote:
> If you can
> export the functionality as modular then you are set, as you can then
> just carry it as a new generic module helper. We have some of these,
> refer to tons of functionality in the directory backport/compat/
> in that take note of the Makefile
> 
> compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o                        
> compat-$(CPTCFG_BPAUTO_CRYPTO_SKCIPHER) += crypto-skcipher.o 
> 
> We copy over from upstream crypto-ccm and throw it in here to
> provide our own copy. Additionally there is also patch for
> it, see patches/backport-adjustments/crypto-ccm.patch
> 
> So the BPAUTO stuff is one of the auto-things we have.

I forgot to refer you also to the c-file trick used to copy
code for this purpose refer to backport/compat/Kconfig:

config BPAUTO_BUILD_CRYPTO_CCM                                                  
        bool                                                                    
        default n if CRYPTO_CCM                                                 
        default y if BPAUTO_CRYPTO_CCM                                          
        #c-file crypto/ccm.c  

That c-file entry means copy upstream's copy to compat/

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
