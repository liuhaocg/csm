package doctor

import "git.xzlcorp.com/backend/csm"

// Assistant model.
type Assistant struct {
	csm.Base
	UserID   int64 `db:"user_id" json:"userId"`
	DoctorID int64 `db:"doctor_id" json:"doctorId"`
}
