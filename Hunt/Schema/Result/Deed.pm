package Hunt::Schema::Result::Deed;
use base qw/DBIx::Class::Core/;
 
__PACKAGE__->table('deed');
__PACKAGE__->add_columns(qw/ tax_map_id first_name last_name street street_number city zip /);
__PACKAGE__->set_primary_key('tax_map_id');
 
1;