<template>
    <div class="row">
        <div class="col-md-9" id="column">
            <div class="card show-card">
                <div class="card-body">
                    <div id="button-console">
                        <div class="btn-group float-right" role="group">
                            <button v-on:click="sortByHours" type="button" class="btn btn-secondary">Hour ASC</button>
                            <button v-on:click="sortByHoursDesc" type="button" class="btn btn-secondary">Hour DESC</button>
                            <button v-on:click="sortByEmployee" type="button" class="btn btn-secondary">Employee ASC</button>
                            <button v-on:click="sortByEmployeeDesc" type="button" class="btn btn-secondary">Employee DESC</button>
                            <button v-on:click="sortByJg" type="button" class="btn btn-secondary">Job Group ASC</button>
                            <button v-on:click="sortByJgDesc" type="button" class="btn btn-secondary">Job Group DESC</button>
                        </div>
                    </div>
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Date</th>
                                <th scope="col">Hours Worked</th>
                                <th scope="col">Employee ID</th>
                                <th scope="col">Job Group</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="cs in reportData" v-bind:cs="cs" v-bind:key="cs.key">
                                <td>{{ cs.date }}</td>
                                <td>{{ cs.hours_worked }}</td>
                                <td>{{ cs.employee_id }}</td>
                                <td>{{ cs.job_group }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            report: this.one_report,
            reportData: [],
        }
    },
    props: ['one_report'],
    watch: {
        one_report: function() {
            const id = this.one_report.id
            this.report = this.one_report
            $.ajax({
                type: "GET",
                url: '/get_report_data',
                data: { id: id},
                error: (err) => {
                    console.log(err)
                },
                success: (data) => {
                    this.reportData = data.filter((d) => {
                        if(d.date != "report id"){
                            return d
                        }
                    })
                }

            })
        }
    },
    methods: {
        sortByHours(){
            return this.reportData.sort((a, b) => Number(a.hours_worked) - Number(b.hours_worked))
        },
        sortByHoursDesc(){
            return this.reportData.sort((a, b) => Number(b.hours_worked) - Number(a.hours_worked))
        },
        sortByEmployee(){
            return this.reportData.sort((a, b) => Number(a.employee_id) - Number(b.employee_id))
        },
        sortByEmployeeDesc(){
            return this.reportData.sort((a, b) => Number(b.employee_id) - Number(a.employee_id))
        },
        sortByJg() {
            return this.reportData.sort(function(a, b){ 
                if(a.job_group < b.job_group){ return -1 }
                if(a.job_group > b.job_group){ return 1 } 
            })
        },
        sortByJgDesc(){
            return this.reportData.sort(function(a, b){ 
                if(a.job_group > b.job_group){ return -1 }
                if(a.job_group < b.job_group){ return 1 } 
            })
        }
    }
}
</script>

<style scoped>
.card.show-card {
    height: 100vh;
    overflow: hidden;
    overflow: scroll;
}
#column {
    padding-top: 2%;
}
.btn-group {
    margin-bottom: 10px;
    width: 100%;
}
tr:hover {
    background-color: lightgray;
    cursor: pointer;
}
</style>