<template>
<div>
    <form>
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
                <div class="card-body">
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
            <input type="file" id="file" ref="myFiles" class="form-control-file" 
            @change="submitFile" multiple>
        </div>
    </form>
    <reporttable v-if="submitted" :submittedCsv="csv" :submitted="submitted"/>
</div>
</template>

<script>
import reporttable from '../tables/reporttable'

export default {
    data() {
        return {
            csv: [],
            name: '',
            submitted: false,
            isError: false,
            errorMessage: ''
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
                        console.log(data)
                    },
                    error: (err) => {
                        console.log(err)
                        this.isError = true
                    }
                })
            } else {
                this.isError = true
                this.errorMessage = "You must have both a report imported and a name for your report"
            }
        }
    }
}
</script>

<style lang="scss">
.card {
    width: 100%;
}
</style>