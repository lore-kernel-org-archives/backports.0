Return-path: <backports-owner@vger.kernel.org>
Received: from mail-eopbgr720106.outbound.protection.outlook.com ([40.107.72.106]:18080
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932590AbeFKKaC (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 11 Jun 2018 06:30:02 -0400
Date: Mon, 11 Jun 2018 05:29:49 -0500
From: Wan-Hua Chang <winnie.chang@cypress.com>
To: backports@vger.kernel.org
Cc: Chi-Hsien.Lin@cypress.com
Subject: Re: [PATCH] Updating id field in backports genl family
Message-ID: <20180611102947.GA188023@aremote01.aus.cypress.com> (sfid-20180611_123004_861733_D37D3B95)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

I see the patch causes compiling error becasue family->family is not
found when LINUX_VERSION >= 3.13

backports/backport/backport-include/genetlink.h
struct backport_genl_fmaily is only defined when LINUX_VERSION < 3.13


And in backports/backport/compat/backport-3.13.c line 127 

family->id = family->family.id

it looks like this line has done what the patch want to do. Is the
comprehension correct?
--
To unsubscribe from this list: send the line "unsubscribe backports" in
