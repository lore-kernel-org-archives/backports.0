Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:61585 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935574Ab3DHTby (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Apr 2013 15:31:54 -0400
Received: by mail-la0-f49.google.com with SMTP id fs12so1022876lab.8
        for <backports@vger.kernel.org>; Mon, 08 Apr 2013 12:31:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365416773-12836-9-git-send-email-thierry.escande@linux.intel.com>
References: <1365416773-12836-9-git-send-email-thierry.escande@linux.intel.com>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Mon, 8 Apr 2013 12:31:32 -0700
Message-ID: <CAB=NE6WWA4r+FyqR484ZJJm_usrCRDOjzMut-6JawNXJXUNmvw@mail.gmail.com> (sfid-20130408_213157_584530_A7D4DCF5)
Subject: Re: [PATCH v3 8/8] build: add NFC defconfig file
To: Thierry Escande <thierry.escande@linux.intel.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Apr 8, 2013 at 3:26 AM, Thierry Escande
<thierry.escande@linux.intel.com> wrote:
> Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
> ---
>  backport/defconfigs/nfc |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 backport/defconfigs/nfc
>
> diff --git a/backport/defconfigs/nfc b/backport/defconfigs/nfc
> new file mode 100644
> index 0000000..999127f
> --- /dev/null
> +++ b/backport/defconfigs/nfc
> @@ -0,0 +1,11 @@
> +CPTCFG_NFC=m
> +CPTCFG_NFC_NCI=m
> +CPTCFG_NFC_HCI=m
> +CPTCFG_NFC_SHDLC=y
> +CPTCFG_NFC_LLCP=y
> +CPTCFG_NFC_PN533=m
> +CPTCFG_NFC_WILINK=m
> +CPTCFG_NFC_PN544=m
> +CPTCFG_NFC_PN544_I2C=m
> +CPTCFG_NFC_MICROREAD=m
> +CPTCFG_NFC_MICROREAD_I2C=m

Johannes, do we want to be disabling the other subsystems in these ?

  Luis
