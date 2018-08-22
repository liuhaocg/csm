package medicine

import (
	"git.xzlcorp.com/backend/csm"
	"github.com/douglarek/dbkit/dbc"
	"github.com/gocraft/dbr"
)

// Medicine model.
type Medicine struct {
	csm.Base
	ApprovalNo    string        `db:"approval_no" json:"approvalNo"`
	Name          string        `db:"name" json:"name"`
	EngName       string        `db:"eng_name" json:"engName"`
	CommodityName string        `db:"commodity_name" json:"commodityName"`
	DosageForm    string        `db:"dosage_form" json:"dosageForm"`
	Strength      string        `db:"strength" json:"strength"`
	Company       string        `db:"company" json:"company"`
	Address       string        `db:"address" json:"address"`
	Type          string        `db:"type" json:"type"`
	ApprovalDate  dbc.TimeStamp `db:"approval_date" json:"approvalDate"`
	OrigApvNo     string        `db:"orig_apv_no" json:"origApvNo"`
	DrugCode      string        `db:"drug_code" json:"drugCode"`
	DrugCodeNote  string        `db:"drug_code_note" json:"drugCodeNote"`
	Country       string        `db:"country" json:"country"`
	EndDate       dbc.TimeStamp `db:"end_date" json:"endDate"`
	PkgStrength   string        `db:"pkg_strength" json:"pkgStrength"`
	CfdaID        string        `db:"cfda_id" json:"cfdaId"`
	Imported      int           `db:"imported" json:"imported"`
	Note          string        `db:"note" json:"note"`
}

// Summary for medicine just contains id, name, company
type Summary struct {
	ID      int64  `db:"id" json:"id"`
	Name    string `db:"name" json:"name"`
	Company string `db:"company" json:"company"`
}

// SummarysByKeyName returns medicine list by key name.
func SummarysByKeyName(s *dbr.Session, name string, page, perPage int) (sm []Summary) {
	if page == 0 {
		page = 1
	}
	if perPage > 50 {
		perPage = 50
	}
	s.Select("id, name, company").From("s_medicine.t_medicine").Where("name ~ ?", name).Offset(uint64(page * perPage)).Limit(uint64(perPage)).OrderBy("id").Load(&sm)
	return
}
