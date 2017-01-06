package HEG::DB::Result::Feature;

use warnings;
use strict;

use base qw( DBIx::Class::Core );

__PACKAGE__->table('feature');

__PACKAGE__->add_columns(
  id => {
    data_type => 'integer',
    is_auto_increment => 1
  },
  email => {
    data_type => 'text',
  },
  feature => {
    data_type => 'text',
  }
);

__PACKAGE__->set_primary_key('id');

