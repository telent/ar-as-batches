# ActiveRecord::Relation#as_batches

      Users.where(country_id: 44).as_batches(:batch_size=>200) do |user|
        user.party_all_night!
      end

`ar-as-batches` is what you (might) need if you were hoping `#find_each`
would solve your problem and are disappointed to find that it doesn't.

Like `#find_each` it is intended for batch processing of large (or
unknown) numbers of records that would require excessive memory if an
object for each of the complete result set were created at once.  It
retrieves records from your relation in batches of 1000 (or as
specified by the `:batch_size` option) and yields each record.

Unlike `#find_each` it honours `order`, `limit` and `offset` options
on your query, so if you want records in reverse chronological order
instead of ascending date order, and you want to start on page 2:
you're welcome.

