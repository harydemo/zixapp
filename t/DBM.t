use Zeta::Run;
use ZAPP::DBM;
use Data::Dump;

do "$ENV{ZIXAPP_HOME}/libexec/plugin.pl";
zkernel->load_plugin('dbh');
zkernel->init_plugin('dbh', undef);

my $dbh = zkernel->zapp_dbh();

my $dbm = ZAPP::DBM->new( dbh => $dbh);

#  book => 'bamt_yhyf'
#  pdel => 'p_0'
#  padd => {
#       start => 'xxxx',
#       end   => 'xxxx',
#       name => 'p_1',
#       tbsp  => {
#           dir  => '/tmp',
#           name => 'tbsp_1',
#           size => '2G',
#           pagesize => '8k',
#           bufferpool => 'bk32k',
#       },
#  },

$dbm->mqt_maint(
     {
         book => 'bamt_yhyf',
         pdel => 'p_0',
         padd => {
              start => 'xxxx',
              end   => 'xxxx',
              name => 'p_1',
              tbsp  => {
                  name => 'tbsp_1',
                  create => {
                      dir  => '/tmp',
                      size => '2G',
                      pagesize => '8k',
                      bufferpool => 'bk32k',
                  },
              },
         },
     }
);




