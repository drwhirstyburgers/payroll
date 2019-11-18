<template>
<div id="console-cards">
    <div class="card console">
        <div class="card-body">
            <h5>Report: {{ report.name }}</h5>
            <h6 class="card-text">Created on: {{ moment(report.created_at).format('MMMM Do YYYY') }}</h6>
            <h6 v-for="(value, key) in wageData.sums" v-bind:value="value" v-bind:key="value.key" class="card-text">{{ key }}: ${{ value }}</h6>
            <hr>
            <h5>Employee ID: {{ selectedRow.employee_id }}</h5>
            <h6>Hours worked: {{ selectedRow.hours_worked }} </h6>
            <h6>Wage Group: {{ selectedRow.job_group }}</h6>
            <h6>Amount owed for shift: ${{ totalPaid }}</h6>
        </div>
    </div>
    <div class="card console">
        <div class="card-body">
            <h5>Report totals for employee</h5>
            <h6>Total hours: {{ totals.total_hours }}</h6>
            <h6>Total amount owed on report: ${{totals.sum_owed}}</h6>
        </div>
    </div>
</div>
</template>

<script>
export default {
    data(){
        return {
            report: this.reportData,
            selectedRow: {},
            wageData: this.wage_data,
            totalPaid: 0,
            totals: {}
        }
    },
    watch: {
        reportData: function(){
            this.report = this.reportData
        },
        selectRow: function(){
            this.selectedRow  = this.selectRow[0]
            this.totals = this.selectRow[1]
            this.totalPaid = this.sumOfHours()
        },
        wage_data: function(){
            this.wageData  = this.wage_data
        }
    },
    props: ['reportData', 'selectRow', 'wage_data'],
    methods:{
        sumOfHours(){
            const group = this.getJobGroupWage(this.selectedRow.job_group)
            return this.selectedRow.hours_worked * group.wage
        },
        getJobGroupWage(name){
            return this.wageData.groups_and_wages.find(w => w.name == name)
        }
    }
}
</script>

<style scoped>
.card.console {
    height: auto;
    margin-top: 10%;
}
#console-cards {
    height: 95vh;
    overflow: hidden;
    overflow: scroll;
}
</style>