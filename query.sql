select 
    p.customer_id,
    sum(r.amount) total_refund
from refund r
join purchase p on p.id = r.parent_id
left join void v on v.parent_id = p.id
where v.id is null    -- removing all transactions with a child thats void
and date_trunc('month', p.timestamp) != date_trunc('month', r.timestamp)    -- removing all refunds that occurred in the same month as parent transaction
group by p.customer_id
