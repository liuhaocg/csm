package doctor

import (
	"errors"

	"git.xzlcorp.com/backend/csm"

	"golang.org/x/crypto/bcrypt"

	"github.com/douglarek/dbkit/dbc"
	"github.com/gocraft/dbr"
)

var (
	errUserNotFound        = errors.New("user not found")
	errUserPasswordInvalid = errors.New("password is invalid")
)

// User model.
type User struct {
	csm.Base
	Name      string        `db:"name" json:"name"`
	Password  string        `db:"password" json:"-"`
	Birthday  dbc.TimeStamp `db:"birthday" json:"birthday"`
	Sex       int           `db:"sex" json:"sex"` // 0 -> male, 1 -> female, 2 -> others
	Type      int           `db:"type" json:"type"`
	Avatar    string        `db:"avatar" json:"avatar,omitempty"`
	Cellphone *string       `db:"cell_phone" json:"cellphone"`
}

// CheckUser checks if a user is valid.
func CheckUser(s *dbr.Session, cell, pass string) (user *User, err error) {
	s.Select("*").From("s_doctor.t_user").Where(dbr.And(dbr.Eq("deleted_at", nil), dbr.Eq("cell_phone", cell))).Limit(1).Load(&user)
	if user == nil {
		return nil, errUserNotFound
	}
	if bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(pass)) != nil {
		return nil, errUserPasswordInvalid
	}
	return user, nil
}

// UserByCellphone returns an user by cellphone.
func UserByCellphone(s *dbr.Session, cell string) (user *User, err error) {
	s.Select("*").From("s_doctor.t_user").Where(dbr.And(dbr.Eq("deleted_at", nil), dbr.Eq("cell_phone", cell))).Limit(1).Load(&user)
	if user == nil {
		return nil, errUserNotFound
	}
	return user, nil
}
