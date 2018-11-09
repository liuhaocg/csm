package push

import (
	"git.xzlcorp.com/backend/csm"
	"github.com/gocraft/dbr"
)

// Device ...
type Device struct {
	csm.Base
	Type     string `db:"type" json:"type"`
	Token    string `db:"token" json:"token"`
	ObjectID string `db:"object_id" json:"objectId"`
}

// BindDevice ...
func BindDevice(s *dbr.Session, dtype, token, objectID string) error {
	r, err := s.Update("s_push.t_device").SetMap(map[string]interface{}{"object_id": objectID, "deleted_at": nil}).Where(dbr.Eq("token", token)).Exec()
	if err != nil {
		return err
	}
	n, err := r.RowsAffected()
	if err != nil {
		return err
	}
	if n == 0 {
		_, err := s.InsertInto("s_push.t_device").Columns("type", "token", "object_id").Record(&Device{Type: dtype, Token: token, ObjectID: objectID}).Exec()
		if err != nil {
			return err

		}
	}
	return nil
}

// UnbindDevice ...
func UnbindDevice(s *dbr.Session, token string) (string, error) {
	var objecyID string
	_, err := s.Select("object_id").From("s_push.t_device").Where(dbr.Eq("token", token)).Limit(1).Load(&objecyID)
	return objecyID, err
}
