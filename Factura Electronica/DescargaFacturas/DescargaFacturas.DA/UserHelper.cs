using System.Linq;

namespace DescargaFacturas.DA
{
	public class UserHelper
    {
        public static Users Authenticate(string username, string password)
        {
            using (var context = new CCFNEntities())
            {
                return context.Users
                    .Include("UserRoleXREF")
                    .Include("UserRoleXREF.Roles")
                    .FirstOrDefault(x => x.Username == username && x.Password == password && x.ActiveFlag);
            }
        }
    }
}