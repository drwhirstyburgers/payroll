<template>
    <form v-on:submit.prevent>
        <h1 v-if="!editing" class="display-4">New Employee</h1>
        <h1 v-if="editing" class="display-4">Edit Employee</h1>
        <h1 v-if="isError" v-on:click="isError = false" class="display-4">You must provide an employee ID and name and the ID must be unique</h1>
        <div class="form-group">
            <label>Employee ID</label>
            <input v-model="employeeId" type="number" class="form-control" placeholder="ID">
        </div>
        <button v-on:click="sendForm" type="submit" class="btn btn-primary float-right">Submit</button>
    </form>
</template>

<script>
export default {
    data() {
        return {
            employeeId: null,
            editing: false,
            employee: {},
            isError: false
        }
    },
    props: ['edit'],
    mounted(){
        this.setDataOnEdit()
    },
    methods: {
        sendForm(){
            if(this.employeeId == null || this.employeeId == ''){
                this.isError = true
            } else {
                if(this.editing == true){
                    $.ajax({
                        type: 'PUT',
                        url: '/employees/' + this.employee.id,
                        data: { employee: { employee_id: this.employeeId } },
                        error: (err) => {
                            console.log(err)
                            this.isError = true
                        }
                    })
                } else {
                    $.ajax({
                        type: 'POST',
                        url: '/employees',
                        data: { employee: { employee_id: this.employeeId } },
                        error: (err) => {
                            console.log(err)
                            this.isError = true
                        }
                    })
                }
            }
        },
        setDataOnEdit(){
            if(this.edit != false){
                this.employee = this.edit
                this.name = this.employee.name
                this.employeeId = this.employee.employee_id
                this.editing = true
            }
        }
    }
    
}
</script>