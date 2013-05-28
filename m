Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:52539 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168Ab3E1VNx (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 17:13:53 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so9670595obb.30
        for <backports@vger.kernel.org>; Tue, 28 May 2013 14:13:52 -0700 (PDT)
Message-ID: <51A51E0E.8010803@lwfinger.net> (sfid-20130528_231355_213863_DB02CB57)
Date: Tue, 28 May 2013 16:13:50 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: backports@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: catch make in backport template directory
References: <1369773194-17379-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1369773194-17379-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/28/2013 03:33 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Catch running make in the backport template directory by
> checking for the .local-symbols file. If it isn't there
> then we're in the input/template directory rather than in
> an output tree, give the user a hint about it instead of
> keeling over.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   backport/Makefile | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/backport/Makefile b/backport/Makefile
> index 287b27d..f0c7586 100644
> --- a/backport/Makefile
> +++ b/backport/Makefile
> @@ -37,6 +37,18 @@ mrproper:
>   	@rm -f backport-include/backport/autoconf.h
>
>   .DEFAULT:
> +	@set -e ; test -f .local-symbols || (						\
> +	echo "/--------------"								;\
> +	echo "| You shouldn't run make in the backports tree, but only in"		;\
> +	echo "| the generated output. This here is only the skeleton code"		;\
> +	echo "| copied into the output directory. To use the backport system"		;\
> +	echo "| from scratch, go into the top-level directoroy and run"			;\

=======================================================^ Typo here.

Larry

