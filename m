Return-path: <backports-owner@vger.kernel.org>
Received: from mail.xlhost.de ([84.200.252.118]:55493 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751935Ab3LMIBY (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 13 Dec 2013 03:01:24 -0500
Message-ID: <52AABED2.7000506@kpanic.de> (sfid-20131213_090136_247327_3F748959)
Date: Fri, 13 Dec 2013 09:01:22 +0100
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: mcgrof@kernel.org, backports@vger.kernel.org
Subject: Re: [PATCH RFC 05/10] backports: igb fixes for linux-3.6
References: <1386840482-585-1-git-send-email-sassmann@kpanic.de> <1386840482-585-6-git-send-email-sassmann@kpanic.de> <52AA5901.2060601@hauke-m.de>
In-Reply-To: <52AA5901.2060601@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 13.12.2013 01:46, Hauke Mehrtens wrote:
> On 12/12/2013 10:27 AM, Stefan Assmann wrote:
>> - backport ethtool_cmd
>> - backport ethtool_ops
>> - backport mmd_eee_adv_to_ethtool_adv_t
>> - add patches/collateral-evolutions/network/82-ethernet/igb_ptp.patch
>> - add patches/collateral-evolutions/network/82-ethernet/igb_err_handler.patch
>>
>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>> ---

[...]

>> +struct backport_ethtool_ops {
>> +	int	(*get_settings)(struct net_device *, struct ethtool_cmd *);
>> +	int	(*set_settings)(struct net_device *, struct ethtool_cmd *);
>> +	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
>> +	int	(*get_regs_len)(struct net_device *);
>> +	void	(*get_regs)(struct net_device *, struct ethtool_regs *, void *);
>> +	void	(*get_wol)(struct net_device *, struct ethtool_wolinfo *);
>> +	int	(*set_wol)(struct net_device *, struct ethtool_wolinfo *);
>> +	u32	(*get_msglevel)(struct net_device *);
>> +	void	(*set_msglevel)(struct net_device *, u32);
>> +	int	(*nway_reset)(struct net_device *);
>> +	u32	(*get_link)(struct net_device *);
>> +	int	(*get_eeprom_len)(struct net_device *);
>> +	int	(*get_eeprom)(struct net_device *,
>> +			      struct ethtool_eeprom *, u8 *);
>> +	int	(*set_eeprom)(struct net_device *,
>> +			      struct ethtool_eeprom *, u8 *);
>> +	int	(*get_coalesce)(struct net_device *, struct ethtool_coalesce *);
>> +	int	(*set_coalesce)(struct net_device *, struct ethtool_coalesce *);
>> +	void	(*get_ringparam)(struct net_device *,
>> +				 struct ethtool_ringparam *);
>> +	int	(*set_ringparam)(struct net_device *,
>> +				 struct ethtool_ringparam *);
>> +	void	(*get_pauseparam)(struct net_device *,
>> +				  struct ethtool_pauseparam*);
>> +	int	(*set_pauseparam)(struct net_device *,
>> +				  struct ethtool_pauseparam*);
>> +	void	(*self_test)(struct net_device *, struct ethtool_test *, u64 *);
>> +	void	(*get_strings)(struct net_device *, u32 stringset, u8 *);
>> +	int	(*set_phys_id)(struct net_device *, enum ethtool_phys_id_state);
>> +	void	(*get_ethtool_stats)(struct net_device *,
>> +				     struct ethtool_stats *, u64 *);
>> +	int	(*begin)(struct net_device *);
>> +	void	(*complete)(struct net_device *);
>> +	u32	(*get_priv_flags)(struct net_device *);
>> +	int	(*set_priv_flags)(struct net_device *, u32);
>> +	int	(*get_sset_count)(struct net_device *, int);
>> +	int	(*get_rxnfc)(struct net_device *,
>> +			     struct ethtool_rxnfc *, u32 *rule_locs);
>> +	int	(*set_rxnfc)(struct net_device *, struct ethtool_rxnfc *);
>> +	int	(*flash_device)(struct net_device *, struct ethtool_flash *);
>> +	int	(*reset)(struct net_device *, u32 *);
>> +	u32	(*get_rxfh_indir_size)(struct net_device *);
>> +	int	(*get_rxfh_indir)(struct net_device *, u32 *);
>> +	int	(*set_rxfh_indir)(struct net_device *, const u32 *);
>> +	void	(*get_channels)(struct net_device *, struct ethtool_channels *);
>> +	int	(*set_channels)(struct net_device *, struct ethtool_channels *);
>> +	int	(*get_dump_flag)(struct net_device *, struct ethtool_dump *);
>> +	int	(*get_dump_data)(struct net_device *,
>> +				 struct ethtool_dump *, void *);
>> +	int	(*set_dump)(struct net_device *, struct ethtool_dump *);
>> +	int	(*get_ts_info)(struct net_device *, struct ethtool_ts_info *);
>> +	int     (*get_module_info)(struct net_device *,
>> +				   struct ethtool_modinfo *);
>> +	int     (*get_module_eeprom)(struct net_device *,
>> +				     struct ethtool_eeprom *, u8 *);
>> +	int	(*get_eee)(struct net_device *, struct ethtool_eee *);
>> +	int	(*set_eee)(struct net_device *, struct ethtool_eee *);
>> +};
>> +#define ethtool_ops LINUX_BACKPORT(ethtool_ops)
> 
> Backporting ethtool_ops does not work so easily. The network stack is in
> the old kernel which want to call some function with a pointer from this
> strcut, but it accesses this option not by its name but by the offset in
> this struct it was compiled with. If the kernel and backports are
> getting compiled with a different version of this struct then they could
> have a different opinion on where a certain function pointer is placed
> which will lead to the kernel calling the wrong function. You have to be
> careful when you want to change some structs in backports, this normally
> only works when all users of this strut are in backports.

I agree with you there, so what would be a better way to deal with
changes in struct ethtool_ops? We probably could ifdef out the code in
igb but I assume that would get very ugly rather quickly and would take a
lot of time to maintain and refresh patches against upstream. A solution
which keeps the changes to upstream minimal would be preferable if you
could think of any.

  Stefan
