
import React from 'react'
import { MuiPickersUtilsProvider, DatePicker } from '@material-ui/pickers';
import DateFnsUtils from '@date-io/date-fns';

export default function DateInput({ value, onChange, label }) {
    return (
        <MuiPickersUtilsProvider utils={DateFnsUtils}>
            <DatePicker
                variant="inline"
                inputVariant="filled"
                color="secondary"
                style={{
                    display: "flex",
                    flexGrow: 1,
                    margin: "8px 0px"
                }}
                format="dd.MM.yyyy"
                label={label}
                value={value}
                onChange={(date) => onChange(date)}
            />
        </MuiPickersUtilsProvider>
    )
}
