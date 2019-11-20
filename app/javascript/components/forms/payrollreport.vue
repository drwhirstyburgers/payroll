<template>
<div>
    <newjobgroupmodal v-on:updated="submitUpdatedJobGroups" v-if="stepTwo" :job_groups="newJobGroups" :blank_error="blankError" />
    <form>
        <div class="row">
            <div class='col-md-6'>
                <h1 class="display-4">New Report</h1>
            </div>
            <div class='col-md-6'>
                <button v-on:click="checkJobGroups" type="button" class="btn btn-primary float-right">Submit</button>
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
    <reporttable v-if="submitted" :submitted_csv="csv" :submitted="submitted"/>
    </div>
</div>
</template>

<script>
import reporttable from '../tables/reporttable'
import newjobgroupmodal from '../modals/newjobgroupmodal'
import { all } from 'q'

export default {
    data() {
        return {
            csv: [],
            name: '',
            submitted: false,
            isError: false,
            errorMessage: '',
            newJobGroups: null,
            stepTwo: false,
            reportId: null,
            jobGroupNames: [],
            blankError: false
        }
    },
    components: { reporttable, newjobgroupmodal },
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
        checkJobGroups(){
            if(this.name != '' && this.csv != []){
                const csv = this.csv
                this.jobGroupNames = this.returnUniqueJobGroupNames(csv)
                if(this.jobGroupNamess != null || this.jobGroupNames != undefined || this.jobGroupNames != []){
                    console.log(this.jobGroupNames)
                    $.ajax({
                        type: "POST",
                        url: '/check_job_groups',
                        data: { job_groups: this.jobGroupNames },
                        error: (err) => {
                            console.log(err)
                            alert("there was an error please try again")
                            location.reload();
                        },
                        success: (data) => {
                            if(data == "exists"){
                                this.submitReport()
                            } else {
                                this.newJobGroups = data
                                this.stepTwo = true
                            }
                        }
                    })
                }
            } else {
                this.isError = true
                this.errorMessage = "You must have both a report imported and a name for your report"
            }
        },
        submitUpdatedJobGroups(updatedJobGroups) {
            this.newJobGroups = JSON.stringify(updatedJobGroups)
            if(this.newJobGroups != null || this.newJobGroups != undefined || this.newJobGroups != []){
                $.ajax({
                    type: "POST",
                    url: '/update_job_groups',
                    data: { job_groups: this.newJobGroups },
                    error: (err) => {
                        var error = err.responseText
                        if(error == "blanks"){
                            this.blankError = true
                        }
                        console.log(err)
                    },
                    success: (data) => {
                        this.submitReport()
                    }
                })
            }

        },
        submitReport(){
                this.csv = JSON.stringify(this.csv)
                $.ajax({
                    type: "POST",
                    url: '/payroll_reports',
                    data: { name: this.name, csv: this.csv },
                    success: (data) => {
                        this.newEmploy = data.new_employees
                        this.newJobGroups = data.new_job_groups
                        this.stepTwo = true
                        this.reportId = data.report_id
                    },
                    error: (err) => {
                        var error = err.responseText
                        if(err.responseText == error){
                            alert("Error, this report id already exists.")
                            location.reload();
                        } else {
                            alert("there was an error please try again")
                            location.reload();
                        }
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
        returnUniqueJobGroupNames(csv) {
            console.log("hello")
            const names = csv.map((r) => r.job_group)
            const unique = Array.from(new Set(names));
            const result = unique.filter((n) => {
                if(n != "" || n != undefined){
                    return n
                }
            })
            return result
        },
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