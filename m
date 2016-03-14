Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36671 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934032AbcCNLDE (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 14 Mar 2016 07:03:04 -0400
Received: by mail-lb0-f173.google.com with SMTP id x1so233557780lbj.3
        for <backports@vger.kernel.org>; Mon, 14 Mar 2016 04:03:03 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 14 Mar 2016 13:03:01 +0200
Message-ID: <CANUX_P3KuZRvqNY7jUfptZxFCz5Hb=7UKPAXafL_tW3P3=Ln4Q@mail.gmail.com> (sfid-20160314_120352_880829_BBD21C0E)
Subject: compilation issues with 3.1.0
From: Emmanuel Grumbach <egrumbach@gmail.com>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

One of my colleagues has issues with 3.1.0:
it can't find dma_common_get_sgtable.

HAVE_GENERIC_DMA_COHERENT is set, and hence
BPAUTO_BUILD_DMA_SHARED_HELPERS is not set.
Because of that, dma_common_get_sgtable isn't defined.

Sorry for the stupid question, but I can't think on how
dma_common_get_sgtable should be declared on 3.1 since it doesn't
exist in the base kernel obviously. Maybe that helper is supposed to
be used only in code that should be under ifdef?

thanks...

Emmanuel Grumbach
egrumbach@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe backports" in
