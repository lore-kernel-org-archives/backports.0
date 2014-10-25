Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40691 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbaJYTAw (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 15:00:52 -0400
Message-ID: <544B8EF5.6030900@hauke-m.de> (sfid-20141025_210055_717129_F9A2F8BB)
Date: Sat, 25 Oct 2014 13:52:21 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
CC: backports@vger.kernel.org
Subject: Re: [PATCH] defconfigs: enable PCIe support in brcmfmac defconfig
References: <1412935985-6665-1-git-send-email-arend@broadcom.com>
In-Reply-To: <1412935985-6665-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/10/2014 12:13 PM, Arend van Spriel wrote:
> In 3.17 kernel the brcmfmac supports PCIe host interface. So enable
> support when selecting defconfig-brcmfmac.
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
>  backport/defconfigs/brcmfmac | 1 +
>  1 file changed, 1 insertion(+)
> 

Thank you for the patch, it was applied and pushed out.

hauke
