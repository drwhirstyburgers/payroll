<template>
<div>
    <form v-if=!stepTwo>
        <div class="row">
            <div class='col-md-6'>
                <h1 class="display-4">New Report</h1>
            </div>
            <div class='col-md-6'>
                <button v-on:click="submitReport" type="button" class="btn btn-primary float-right">Submit</button>
            </div>
        </div>
        <div v-if="isError" class="row">
            <div v-on:click="isError = false" class="card">
                <div class="card-body" id="error-card">
                    <h4>Oops! Looks like something went awry, please try again!</h4>
                    <p>{{ errorMessage }}</p>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label>Report Name</label>
            <input v-model="name" type="text" class="form-control" placeholder="Enter the report name">
        </div>
        <div class="form-group">
            <label for="exampleFormControlFile1">Sales Report</label>
            <input type="file" id="file" class="form-control-file" 
            @change="submitFile" multiple>
        </div>
    </form>
    <reporttable v-if="submitted && !stepTwo" :submitted_csv="csv" :submitted="submitted"/>
    <div v-if="stepTwo">
        <div v-if="newEmploy != null">
            <h1 class="display-4">New Employees</h1>
            <div v-for="employ in newEmploy" v-bind:employ="employ" v-bind:key="employ.key" class="card">
                <div class="card-body">
                    <h5 class="card-title">Employee ID: {{ employ.employee_id }}</h5>
                    <div class="form-group">
                        <label>Employee Name</label>
                        <input v-model="employ.name" type="text" class="form-control" placeholder="Enter the employee name">
                    </div>
                </div>
            </div>
        </div>
        <div v-if="newJobGroups != null">
            <h1 class="display-4">New Job Groups</h1>
            <div v-for="jobGroup in newJobGroups" v-bind:jobGroup="jobGroup" v-bind:key="jobGroup.key" class="card">
                <div class="card-body">
                    <h5 class="card-title">Job Group: {{ jobGroup.name }}</h5>
                    <div class="form-group">
                        <label>Wage</label>
                        <input v-model="jobGroup.wage" type="number" class="form-control" placeholder="Enter the wage amount">
                    </div>
                </div>
            </div>
        </div>
        <button v-on:click="submitNewOnes" type="button" class="btn btn-primary float-right">Submit</button>
    </div>
</div>
</template>

<script>
import reporttable from '../tables/reporttable'
import { all } from 'q'

export default {
    data() {
        return {
            csv: [],
            name: '',
            submitted: false,
            isError: false,
            errorMessage: '',
            newEmploy: [],
            newJobGroups: [],
            stepTwo: false,
            reportId: null,
            componentKey:0
        }
    },
    components: { reporttable },
    methods: {
        submitFile(e) {
            const that = this
            const fileToLoad = event.target.files[0]
            const reader = new FileReader()
            reader.onload = fileLoadedEvent => {
                this.$papa.parse(fileLoadedEvent.target.result, {
                    header: true,
                    complete (results) {
                        that.csv = JSON.stringify(results.data).replace(/( +)(?=[(\w* *]*":)/g, "_");
                        that.csv = JSON.parse(that.csv)
                    },
                    error (errors) {
                        console.log('error', errors)
                    }
                })
            }
            reader.readAsText(fileToLoad)
            that.submitted = true
        },
        submitReport(){
            if(this.name != '' && this.csv != []){
                this.csv = JSON.stringify(this.csv)
                $.ajax({
                    type: "POST",
                    url: '/payroll_reports',
                    data: { name: this.name, csv: this.csv },
                    success: (data) => {
                        console.log(data.new_employees)
                        this.newEmploy = data.new_employees
                        this.newJobGroups = data.new_job_groups
                        this.stepTwo = true
                        this.reportId = data.report_id
                    },
                    error: (err) => {
                        console.log(err)
                        alert("Error, please try again")
                        location.reload(true);
                    }
                })
            } else {
                this.isError = true
                this.errorMessage = "You must have both a report imported and a name for your report"
            }
        },
        submitNewOnes(){
            this.newEmploy = JSON.stringify(this.newEmploy)
            this.newJobGroups = JSON.stringify(this.newJobGroups)
            $.ajax({
                type: "POST",
                url: '/payroll_reports/return_new_items',
                data: { employees: this.newEmploy, job_groups: this.newJobGroups, report_id: this.reportId },
                error: (err) => {
                    console.log(err)
                }
            })
        },
        isEmpty(obj) {
            for(var key in obj) {
                if(obj.hasOwnProperty(key))
                    return false;
            }
            return true;
        },
        allEmpty(arr){
            const count = arr.length
            const trueCount = 0
            arr.forEach((obj) => {
                if(this.isEmpty(obj)){
                    return false
                } else {
                    trueCount++
                    if(trueCount == count){
                        return true
                    }
                }
            })
        }
    }
}
</script>

<style lang="scss">
.card {
    width: 100%;
    margin-bottom: 30px;
}
#error-card:hover {
    background-color: rgb(238, 234, 234);
    cursor: pointer;
}
</style>