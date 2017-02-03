using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using DescargaFacturas.DA;

namespace DescargaFacturas.BL
{
	using S = SQL;
	using AL = ArrayList;

	public class UserBL
	{
		public static Users Authenticate(string username, string password)
		{
			using (var db = new CCFNEntities())
				return db.Users.FirstOrDefault(u => u.Username.Equals(username) && u.Password.Equals(password) && u.ActiveFlag && u.StatusName.Equals("APROBADO")); 
		}

		public static Users GetUserById(int userid)
		{
			using (var db = new CCFNEntities())
				return db.Users.Where(u => u.UserId == userid).FirstOrDefault();
		}

		public static Users GetUserByUsername(string username)
		{
			using (var db = new CCFNEntities())
				return db.Users.Where(u => u.Username == username).FirstOrDefault();
		}

		public static List<Roles> GetRoles(int userid)
		{
			using (var db = new CCFNEntities())
				return db.Roles.Where(r => r.UserRoleXREF.Any(ur => ur.UserId == userid) && r.ActiveFlag).ToList();
		}

		public static List<Users> GetPendingUsers()
		{
			using (var db = new CCFNEntities())
				return db.Users.Where(u => u.ActiveFlag && u.StatusName.Equals("PENDIENTE") && u.UserRoles.Contains("CLIENTE")).ToList();
		}

		public static void RemoveRoleFromUser(int userId, int roleId)
		{
			using (var conn = S.GetConnection())
				S.RunQuery("DELETE FROM UserRoleXREF WHERE UserId = @p1 AND RoleId = @p2", new AL() { userId, roleId }, conn, null);
		}

		public static void AddRoleToUser(int userId, int roleId)
		{
			using (var conn = S.GetConnection())
				S.RunQuery("INSERT INTO UserRoleXREF(UserId, RoleId) VALUES(@p1, @p2)", new AL() { userId, roleId }, conn, null);
		}

		public static bool HasRole(List<Roles> lstRoles, string strRole)
		{
			var ret = false;
			lstRoles.ForEach(rol => { if (rol.Name.Equals(strRole)) ret = true; });
			return ret;
		}

		public static bool ExistsRFC(string RFC)
		{
			using (var conn = S.GetConnection())
				return ((int)S.RunQuery("SELECT COUNT(*) FROM Users WHERE RFC = @p1", new AL() { RFC }, conn, null).Rows[0][0]) > 0;
		}

		public static bool ExistsUsername(string Username)
		{
			using (var conn = S.GetConnection())
				return ((int)S.RunQuery("SELECT COUNT(*) FROM Users WHERE Username = @p1", new AL() { Username }, conn, null).Rows[0][0]) > 0;
		}

		public static void AddAdministrator()
		{
			using (var db = new CCFNEntities())
			{
				var user = db.Users.OrderByDescending(u => u.UserId).FirstOrDefault();
				db.UserRoleXREF.Add(new UserRoleXREF() { UserId = user.UserId, RoleId = (int)Constants.Roles.ADMINISTRADOR, Created = DateTime.Now });
				db.SaveChanges();
			}
		}

		public static void RegisterNewClient(Users user)
		{
			using (var db = new CCFNEntities())
			{
				db.Users.Add(user);
				db.SaveChanges();
				db.UserRoleXREF.Add(new UserRoleXREF() { UserId = user.UserId, RoleId = (int)Constants.Roles.CLIENTE, Created = DateTime.Now });
				db.SaveChanges();
			}
		}

		public static void RemoveUserRelationships(int userId)
		{
			using (var db = new CCFNEntities())
			{
				var urx = db.UserRoleXREF.FirstOrDefault(u => u.UserId == userId);
				db.UserRoleXREF.Remove(urx);
				db.SaveChanges();
			}
		}

		public static void ApproveUser(int userId1, int userId2)
		{
			using (var db = new CCFNEntities())
			{
				var user = db.Users.FirstOrDefault(u => u.UserId == userId1);
				user.StatusId = (int)Constants.Status.APROBADO;
				db.SaveChanges();
			}
		}

		public static void RejectUser(int userId1, int userId2)
		{
			using (var db = new CCFNEntities())
			{
				var user = db.Users.FirstOrDefault(u => u.UserId == userId1);
				user.StatusId = (int)Constants.Status.RECHAZADO;
				user.ActiveFlag = false;
				db.SaveChanges();
			}
		}
	}
}