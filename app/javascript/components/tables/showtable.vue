<template>
            <div class="card show-card">
                <div class="card-body">
                    <div id="button-console">
                        <div class="btn-group float-right" role="group">
                            <button v-on:click="sortByEmployee" type="button" class="btn btn-secondary">Employee ASC</button>
                            <button v-on:click="sortByEmployeeDesc" type="button" class="btn btn-secondary">Employee DESC</button>
                            <button v-on:click="sortByDate" type="button" class="btn btn-secondary">Pay Period ASC</button>
                            <button v-on:click="sortByDateDesc" type="button" class="btn btn-secondary">Pay Period DESC</button>
                            <button v-on:click="sortByAp" type="button" class="btn btn-secondary">Amount Paid ASC</button>
                            <button v-on:click="sortByApDesc" type="button" class="btn btn-secondary">Amount Paid DESC</button>
                        </div>
                    </div>
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Employee ID</th>
                                <th scope="col">Pay Period</th>
                                <th scope="col">Amount Paid</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-on:click="displayOnConsole(cs)" v-for="cs in reportData" v-bind:cs="cs" v-bind:key="cs.key">
                                <td>{{ cs.employee_id }}</td>
                                <td>{{ cs.pay_period }}</td>
                                <td>${{ cs.amount_paid }}</td>
                            </tr>
                        </tbody>
                    </table>
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
                    this.reportData = data.report_data.filter((d) => {
                        if(d.date != "report id"){
                            return d
                        }
                    })
                    const wageData = data.wage_data
                    this.$emit('dataProvided', wageData)
                }

            })
        }
    },
    methods: {
        sortByAp(){
            return this.reportData.sort((a, b) => Number(a.amount_paid) - Number(b.amount_paid))
        },
        sortByApDesc(){
            return this.reportData.sort((a, b) => Number(b.amount_paid) - Number(a.amount_paid))
        },
        sortByEmployee(){
            return this.reportData.sort((a, b) => Number(a.employee_id) - Number(b.employee_id))
        },
        sortByEmployeeDesc(){
            return this.reportData.sort((a, b) => Number(b.employee_id) - Number(a.employee_id))
        },
        sortByDate(){
            return this.reportData.sort(function(a, b) { 
                return new Date(a.pay_period.split('-')[1].split('/').reverse().join()) - new Date(b.pay_period.split('-')[1].split('/').reverse().join())
            })
        },
        sortByDateDesc(){
            return this.reportData.sort(function(a, b) { 
                return new Date(b.pay_period.split('-')[1].split('/').reverse().join()) - new Date(a.pay_period.split('-')[1].split('/').reverse().join()) 
            })
        },
        displayOnConsole(cs){
            const consolePayload = []
            $.ajax({
                type: "GET",
                url: '/sum_of_hours_worked',
                data: { employee_id: cs.employee_id, report_id: this.report.id, job_group: cs.job_group },
                success: (data) => {
                    consolePayload.push(data)
                }
            })
            consolePayload.push(cs)
            console.log(consolePayload)
            this.$emit('changeRow', consolePayload)
        },
    }
}
</script>

<style scoped>
.card.show-card {
    height: 95vh;
    overflow: hidden;
    overflow: scroll;
    width: 100%;
    margin-top: 2%;
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