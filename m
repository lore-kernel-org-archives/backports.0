Return-Path: <backports-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D344AC2FC0F
	for <backports@archiver.kernel.org>; Thu, 17 Aug 2023 18:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbjHQSKf (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 17 Aug 2023 14:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243644AbjHQSKE (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 17 Aug 2023 14:10:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF7726A5
        for <backports@vger.kernel.org>; Thu, 17 Aug 2023 11:10:03 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HHxwml031645;
        Thu, 17 Aug 2023 18:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Mzci092eTjBnqd1R2Jr+OYeB2GlILYa8sLs7OAHcYTw=;
 b=VWIhzxGYxwdoDPbNvwaz6I7lzP7UuOPfJo18jcz1qC7AGlM1LJfZb4Dk7gKiLkAfe52L
 WYSKwYOrxA1WAM/MShXwlHDgtOm9dTwz48OV1uFIbAY1ZQG8Qstj9Vle2AD5llgIfwMl
 f/d3u+yUEXmsm+TylMJsueQRsANRqyr5nP4h/4jv8Lr/Yez6ipvLIDUFSxnLBMXknw70
 sUIV+u+ARVg64QAA97d90R+retIyqHVZH9kzssPLu3nM5ASlNx6F3IqdWg7ySBVD7Z8O
 qALlom+nMtRiaT6xhArQjef/Ze9299MiJRBLz7XK+yS2evdgK1h1f3+od9M/fkpVpNkX RA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sh3xxaq6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 18:09:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37HI9kmc019453
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 18:09:46 GMT
Received: from [10.227.89.240] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 17 Aug
 2023 11:09:46 -0700
Message-ID: <7617ac31-6170-4ac8-fa40-acc99b483e8c@quicinc.com>
Date:   Thu, 17 Aug 2023 11:09:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] patches: Avoid NLA_POLICY_RANGE() for
 NL80211_ATTR_EHT_CAPABILITY
To:     <hauke@hauke-m.de>, <mcgrof@kernel.org>
CC:     <backports@vger.kernel.org>
References: <20230222050138.11819-1-quic_alokad@quicinc.com>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <20230222050138.11819-1-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3GrlX91ydKtXVxVfYNovF_E3bN210L9y
X-Proofpoint-ORIG-GUID: 3GrlX91ydKtXVxVfYNovF_E3bN210L9y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_12,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170163
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 2/21/2023 9:01 PM, Aloka Dixit wrote:
> NLA_POLICY_RANGE(NLA_BINARY, ...) is not supported on kernels < 5.10.
> Avoid its use in older kernels for NL80211_ATTR_EHT_CAPABILITY
> which was added in following commit,
> commit ea05fd3581d3 ("cfg80211: Support configuration of station EHT
> capabilities")
> Author: Ilan Peer <ilan.peer@intel.com>
> Date: Mon Feb 14 17:29:58 2022 +0100
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> ---
> v2: Removed the modification of NL80211_ATTR_HE_CAPABILITY which was
> a rebasing error and not related to this commit.
> 
>   patches/0099-netlink-range/mac80211.patch | 27 +++++++++++++++++++----
>   1 file changed, 23 insertions(+), 4 deletions(-)
> 

Hello,
Kindly review this patch.
Thanks.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
