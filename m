Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DFE2587
	for <backports@vger.kernel.org>; Wed, 25 Oct 2023 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailfence.com header.i=brianwitte@mailfence.com header.b="sGHIyPbG"
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472E712F
	for <backports@vger.kernel.org>; Wed, 25 Oct 2023 07:54:11 -0700 (PDT)
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id A5CB210C9;
	Wed, 25 Oct 2023 16:54:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1698245649;
	s=20210208-e7xh; d=mailfence.com; i=brianwitte@mailfence.com;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=3044; bh=DLzdmcWipEDYtk3nZPazsON2Gzaqxj8FQ/C0uiICR40=;
	b=sGHIyPbGWcx9sXBHgapY6WKjGVOgnvZ0Fs7Eio5LNc60n00TqbEmBa8G+CqQ2ML5
	83bsKA9noDe5eUZqiZzvbc/m2EfNoa41zlZGFqWfB0SHyreXPd427Owt3B4XyxTXuqn
	SwDIVggJ0NJzRv+8LrMh0DNSdiZ5OWVFzjQSHJDht0kBIQJu2DxxKUD4A6RBXGZOSao
	/YIleO943NrVp/Jar+eFnfRrE2VnAWZyVAGP8Dhey0gs2bpeQi+ABBaA6jp3iJGHY6p
	Z7QUI5BQ9TgyVo4yowYl44/ekRRaSTwdj25zuHLw/zojxW4o8os1p87We3aYNHOEcvy
	UpxrhU2RAA==
Received: by smtp.mailfence.com with ESMTPSA ; Wed, 25 Oct 2023 16:54:07 +0200 (CEST)
Message-ID: <b67264b6-41f8-4415-ab8a-fbdbac21748e@mailfence.com>
Date: Wed, 25 Oct 2023 09:53:18 -0500
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88, rtw89 -- options for bringing a couple rtw standalone
 GitHub repos into backports.git
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 Larry Finger <Larry.Finger@lwfinger.net>, hauke@hauke-m.de,
 backports@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
References: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com>
 <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net>
 <029db1c1-2ac8-430e-915b-beb7c3741de2@lwfinger.net>
 <0b543e2e6aa3f2473d7ed8e406b74b69e1804143.camel@sipsolutions.net>
 <1a600228-6975-4798-b2df-89d99007337e@mailfence.com>
 <18fb6b9a0e1d2a7cc08eaa34979067e7094bb2a1.camel@sipsolutions.net>
From: Brian Witte <brianwitte@mailfence.com>
In-Reply-To: <18fb6b9a0e1d2a7cc08eaa34979067e7094bb2a1.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-ContactOffice-Account: com:441463380

Sm9oYW5uZXMsDQoNClRoYW5rIHlvdSBmb3IgcXVpY2sgcmVwbHkuDQoNCj4gDQo+PiBJIGFt
IGdvaW5nIHRvIGZpcnN0IHRyeSBhIHZhcmlhdGlvbiBvZiB0aGUgYXBwcm9hY2ggeW91IHN1
Z2dlc3RlZCB3aGVyZQ0KPj4gSSBnZW5lcmF0ZSBiYWNrcG9ydHMgZm9yIExpbnV4IHZlcnNp
b25zIGluIHRoZSByZXBvIGluIGFzY2VuZGluZyBvcmRlcg0KPj4gdGhlbiBoYXZlIG91ciBN
YWtlZmlsZSBkZXRlY3QgdXNlcidzIHZlcnNpb24gYW5kIGluc3RhbGwgYWNjb3JkaW5nbHku
DQo+IA0KPiBXYWl0LCBubywgd2hhdD8gWW91IGRvbid0IG5lZWQgdG8gZGV0ZWN0IHRoZSB1
c2VyJ3MgdmVyc2lvbiBvciBhbnl0aGluZy4NCj4gDQoNCkFoLCB5ZXMhIE9rLCB3b3cuIFNv
cnJ5LiBUaGluZ3MgYXJlIGZpbmFsbHkgYWRkaW5nIHVwLi4uIMKs4oC/wqwNCg0KPiBObyBu
bywgbWlzdW5kZXJzdGFuZGluZyBoZXJlIEkgdGhpbmsuIFlvdSBkb24ndCBuZWVkIGFueXRo
aW5nIGdyYW51bGFyDQo+IGF0IGFsbCwgKmFsbCogeW91ciB1c2VycyBzaG91bGQgYmUgYWJs
ZSB0byB1c2UgYSAqc2luZ2xlKiBjdXJyZW50DQo+IGJhY2twb3J0cy1iYXNlZCBwYWNrYWdl
Lg0KPiANCj4gVGhlIGdyYW51bGFyaXR5IHF1ZXN0aW9uIG9ubHkgY29tZXMgaW4gd2hlbiB5
b3Ugc2F5IGhhdmUgYSB1c2VyIHdobw0KPiByZXBvcnRzIHRoYXQgc29tZXRoaW5nIGRvZXNu
J3Qgd29yay4gTm93IHdoYXQsIGhvdyBkbyB5b3UgZ2V0IHRoZW0gdG8NCj4gZS5nLiBiaXNl
Y3Q/IFJpZ2h0IG5vdyB5b3UgaGF2ZSBhIGdpdCB0cmVlIHRoZXkgY2FuIG5vcm1hbGx5IGJp
c2VjdCBpbi4NCj4gDQo+IE5vdywgaWYgeW91DQo+ICAgLSByZWxlYXNlIGJhY2twb3J0cyB0
YXJiYWxscyBmb3IgdGhlbSB0byB1c2UsIG9yDQo+ICAgLSBjb21taXQgdGhlIG91dHB1dCBv
ZiBiYWNrcG9ydHMgaW50byBhIGdpdCB0cmVlIGZvciB0aGVtIHRvIHVzZQ0KPiANCj4gKnRo
ZW4qIHlvdSBnZXQgaW50byB0aGUgZ3JhbnVsYXJpdHkgcXVlc3Rpb24sIHdoaWNoIGVuZHMg
dXAgYmVpbmcgYQ0KPiB0cmFkZS1vZmYgYmV0d2VlbiB3aGF0J3MgZWZmZWN0aXZlbHkgYmlz
ZWN0YWJpbGl0eSAoeW91IGRvbid0IHJlYWxseQ0KPiBuZWVkIHRvIGNhcmUgYWJvdXQgdGhl
IGhpc3RvcnksIGFmdGVyIGFsbCwgaXQncyBwcmVzZXJ2ZWQgdXBzdHJlYW0pLCBhbmQNCj4g
ZWZmb3J0IG9uIHlvdXIgZW5kIHRvIGdlbmVyYXRlIChhbmQgdGVzdCkgdGhlbSBhbGwuDQo+
IA0KDQpSaWdodCwgeWVzLg0KDQoNCj4+IEFmdGVyIHRoYXQsIG91ciBNYWtlZmlsZSBhbmQv
b3Igc2NyaXB0cyBpdCBjb29yZGluYXRlcyB3aWxsIGhhdmUgdG8NCj4+IGRldGVjdCB0aGUg
dXNlciB2ZXJzaW9uLCB0aGVuIGNkIGludG8gdGhhdCBwYWNrYWdlLCBhbmQgaW5zdGFsbCBp
dA0KPj4gcHJvcGVybHkuDQo+Pg0KPiANCj4gTm8sIHlvdSBzaG91bGQganVzdCBnaXZlIHRo
ZW0gdGhlIG91dHB1dCBvZiBiYWNrcG9ydHMgKGdlbnRyZWUucHkpDQo+IGRpcmVjdGx5LCBp
dCBkb2VzIGFsbCB0aGlzLg0KPiANCj4+IEkgYW0gc3VzcGVuZGluZyBhbnkgdXBzdHJlYW0g
Y29tbWl0IGhpc3Rvcnkgc2hlbmFuaWdhbnMgZm9yIGENCj4+IGxhdGVyIHBvaW50IGFzIG1h
a2luZyBzdXJlIHRoZSBkcml2ZXIgaXMgcGVyZm9ybWFudCBhbmQgaW4tbGluZSB3aXRoIHRo
ZQ0KPj4gdXAtdG8tZGF0ZSB3aXJlbGVzcyBzdGFjay4NCj4gDQo+IE9LLCBzbyB0aGVuIHlv
dSBqdXN0IG5lZWQgdG8gcmVsZWFzZSBhIHNpbmdsZSB0YXJiYWxsIGVmZmVjdGl2ZWx5Lg0K
PiBXaGV0aGVyIGFzIGEgZ2l0IGJyYW5jaCBvciBhIGxpdGVyYWwgdGFyYmFsbCBpcyBwcmV0
dHkgbXVjaCBpcnJlbGV2YW50Lg0KPiANCg0KDQpPaywgSSBub3cgdW5kZXJzdGFuZC4NCg0K
SSB0aGluayBiZWNhdXNlIG9mIHRoZSB3YXkgSSB3YXMgdHJ5aW5nIHRvIGRvIHRoaW5ncyBi
ZWZvcmUgSSB3YXMgDQpmYWlsaW5nIHRvIHNlZSBob3cgcmFkaWNhbGx5IGJhY2twb3J0cyBj
b3VsZCBzaW1wbGlmeSB0aGUgdGFzayBpbiBtYW55IA0Kd2F5cy4gVGhlIGFwcHJvYWNoIEkg
aGF2ZSBiZWVuIHVzaW5nIGlzIGZhciBhd2F5IGZyb20gdGhpcyB3YXkgb2YgZG9pbmcgDQp0
aGluZ3MuDQoNCkkgYW0gZ29pbmcgdG8gZ2V0IHN0YXJ0ZWQgbm93Lg0KDQpBZ2FpbiwgdGhh
bmsgeW91IGZvciB5b3VyIHBhdGllbmNlIGFuZCBoZWxwLg0KDQpUaGFua3MsDQpCcmlhbiBX
aXR0ZQ0K
